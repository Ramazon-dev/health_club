import 'package:dio/dio.dart';
import '../core.dart';

abstract class BaseProvider {
  String buildPath(String path, {int? port}) {
    if (port == null) return path;
    return ':$port$path';
  }

  Future<ApiResponse<T>> apiCall<T>(
      Future<Response> request, {
        required T Function(dynamic data) dataFromJson,
        T? Function(dynamic errorData)? errorDataFromJson,
      }) async {
    try {
      final response = await request;
      print('object response ${response.data}');
      return ApiResponse(dataFromJson(response.data));
    } on DioException catch (e, s) {
      print('object dio catch exception e message ${e.message}');
      print('object dio catch exception e response ${e.response}');
      print('object dio catch exception e type ${e.type}');
      if (e.error is SessionExpiredException) {
        throw SessionExpiredException();
      }

      final errors = e.response?.data.toString();
      if (errors != null &&
          (errors.contains('card_is_blacklisted') ||
              errors.contains('user_is_blocked') ||
              errors.contains('device_is_blocked'))) {
        throw UserBlockedException('user_is_blocked');
      }
      if (e.response?.statusCode == 502 || e.response?.statusCode == 500) {
        return ApiResponse<T>(
          null,
          message: 'server_error',
          meta: {
            'exception': e,
            'stackTrace': s,
          },
        );
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiResponse<T>(
            null,
            message: 'connection TimeOut',
            meta: {
              'exception': e,
              'stackTrace': s,
            },
          );
        case DioExceptionType.connectionError:
          return ApiResponse<T>(
            null,
            message: 'no_internet',
            meta: {
              'exception': e,
              'stackTrace': s,
            },
          );
        case DioExceptionType.badCertificate:
          return ApiResponse<T>(
            null,
            message: e.message,
            meta: {
              'exception': e,
              'stackTrace': s,
            },
          );
        case DioExceptionType.badResponse:
          final data = e.response?.data['detail'];
          if (data == 'Invalid token') {
            print('object bad e.response?.data["detail"] into if ');
            // final cubit = GetIt.I.get<UserRegisteredCubit>();
            // cubit.removeAuthentication();
          }
          print('object base provider bad response ${e.response?.data['detail']}');
          return ApiResponse<T>(
            null,
            message: e.response?.data['detail'],
          );
        case DioExceptionType.unknown:
          final errorData = e.response?.data;
          if (errorData != null) {
            try {
              final errorResponse = ApiResponse(null, message: e.response?.data['detail']);

              return ApiResponse<T>(
                errorResponse.data,
                message: errorResponse.message,
              );
            } catch (ee) {
              return ApiResponse(
                null,
                message: ['Error ${e.response?.data}'],
              );
            }
          }
          return ApiResponse(
            null,
            message: ['Error code: ${e.response?.statusCode}'],
          );
        case DioExceptionType.cancel:
          throw RequestCancelled(e.message);
      }
    } on RequestCancelled {
      rethrow;
    } on Exception catch (e, s) {
      print('object catch exception e $e');
      print('object catch exception s $s');
      return ApiResponse<T>(
        null,
        message: 'something Went Wrong',
      );
    } catch (e) {
      print('object catch e $e');
      return ApiResponse<T>(
        null,
        message: 'something Went Wrong',
      );
    }
  }
}
