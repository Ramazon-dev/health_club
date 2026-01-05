import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'network_watcher.dart';

/// Кастомный интерцептор для автоматического обновления токенов и обработки ошибок
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final Function()? logPrint;
  final NetworkWatcher watcher;
  final Future<void> Function()? toNoInternetPageNavigator;
  final Future<String?> Function() accessTokenGetter;
  final Future<void> Function()? forbiddenFunction;
  final Future<bool> Function() refreshTokenFunction;

  /// Флаг для предотвращения циклических запросов при обновлении токена
  bool _isRefreshing = false;

  /// Очередь запросов, которые ожидают обновления токена
  // final List<RequestOptions> _requestsNeedRetry = [];

  // ВАЖНО: храним и options, и handler
  final List<_Queued> _queue = [];
// Новая: offline-очередь
  final List<_Queued> _offlineQueue = [];
  StreamSubscription<NetStatus>? _netSub;

  RetryInterceptor({
    required this.dio,
    this.logPrint,
    required this.watcher,
    this.toNoInternetPageNavigator,
    required this.accessTokenGetter,
    this.forbiddenFunction,
    required this.refreshTokenFunction,
  }) {
    // Когда сеть появилась — переиграть offline-очередь
    _netSub = watcher.stream.listen((s) {
      if (s == NetStatus.online) _flushOfflineQueue();
    });

  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Добавляем токен авторизации к каждому запросу
    final token = await accessTokenGetter();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    // По умолчанию считаем GET безопасным для авторетрая
    options.extra.putIfAbsent('replayOnReconnect', () => options.method == 'GET');
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('object on error url ${err.requestOptions.uri.path} type ${err.type.name} status ${err.response
        ?.statusCode} error ${err.response?.data}');
    final response = err.response;
    final opts = err.requestOptions;



    // Обработка отсутствия интернета
    if (_isNetworkError(err)) {
      final canReplay = opts.extra['replayOnReconnect'] == true;
      if (canReplay) {
        // навигация "нет интернета" — по желанию
        await toNoInternetPageNavigator?.call();

        // удерживаем запрос и дождёмся онлайна
        _offlineQueue.add(_Queued(opts, handler));
        // если вдруг сеть уже есть (мы ошибку получили из-за моментного сбоя) — попробуем сразу
        if (watcher.isOnline) _flushOfflineQueue();
        return; // ВАЖНО: не вызываем handler.next(err)
      } else {
        logPrint?.call();
        return handler.next(err);
      }

      // logPrint?.call();
      // await toNoInternetPageNavigator?.call();
      // return handler.next(err);
    }
    // защитимся от бесконечного цикла ретраев этим флажком
    final alreadyRetried = err.requestOptions.extra['skipAuthRetry'] == true;
    print('object retry interceptor error status ${response?.statusCode} already retried $alreadyRetried');


    // Обработка 401 ошибки (неавторизован)
    if (response?.statusCode == 401 && !alreadyRetried) {
      _queue.add(_Queued(err.requestOptions, handler));
      if (_isRefreshing) return;
      _isRefreshing = true;

      try {
        final ok = await refreshTokenFunction();
        final queued = List<_Queued>.from(_queue);
        _queue.clear();
        if (ok) {
          final newToken = await accessTokenGetter();
          for (final q in queued) {
            try {
              q.options.headers['Authorization'] = (newToken ?? '');
              q.options.extra['skipAuthRetry'] = true;

              final response = await dio.fetch(q.options);
              q.handler.resolve(response);
            } catch (e) {
              if (e is DioException) {
                print('object retry interceptor retry catch error ${e.response?.data} and status ${e.response?.statusCode}');
                q.handler.next(e);
              } else {
                q.handler.next(DioException(
                  requestOptions: q.options,
                  error: e,
                  type: DioExceptionType.unknown,
                ));
              }
            }
          }
        } else {
          print('object retry interceptor refresh не удался — разлогиниваем и прокидываем ошибки всем ожидающим');
          // refresh не удался — разлогиниваем и прокидываем ошибки всем ожидающим
          await forbiddenFunction?.call();
          for (final q in queued) {
            q.handler.next(DioException(
              requestOptions: q.options,
              response: Response(
                requestOptions: q.options,
                statusCode: 401,
                data: {'message': 'Unauthorized'},
              ),
              type: DioExceptionType.badResponse,
            ));
          }
        }
      } finally {
        _isRefreshing = false;
      }
      return;
    }



    // Обработка 403 ошибки (заблокирован/запрещен)
    if (response?.statusCode == 403) {
      print('object status code 403 ${response?.data}');
      await forbiddenFunction?.call();
      return handler.next(err);
    }

    handler.next(err);
  }
  // Повторяем offline-запросы после восстановления сети
  Future<void> _flushOfflineQueue() async {
    if (_offlineQueue.isEmpty) return;

    final queued = List<_Queued>.from(_offlineQueue);
    _offlineQueue.clear();

    for (final q in queued) {
      try {
        // при желании добавь лимит ожидания/таймаут
        final res = await dio.fetch(q.options);
        q.handler.resolve(res);
      } catch (e) {
        if (e is DioException && _isNetworkError(e)) {
          // сеть снова отвалилась — вернём в очередь
          _offlineQueue.add(q);
          // и выйдем, дождёмся следующего online
          return;
        }
        if (e is DioException) {
          q.handler.next(e);
        } else {
          q.handler.next(DioException(
            requestOptions: q.options,
            error: e,
            type: DioExceptionType.unknown,
          ));
        }
      }
    }
  }

  /// Проверка, является ли ошибка сетевой
  bool _isNetworkError(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.error is SocketException);
  }
  void dispose() => _netSub?.cancel();
}

class _Queued {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;

  _Queued(this.options, this.handler);
}
