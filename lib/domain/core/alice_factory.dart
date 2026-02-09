import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:flutter/material.dart';

class AliceFactory {
  static final AliceFactory _instance = AliceFactory._();

  factory AliceFactory() => _instance;

  AliceFactory._();

  static Alice? _alice;
  static AliceDioAdapter? _aliceChopperAdapter;

  Alice get alice {
    if (_alice != null) return _alice!;
    _alice = Alice(
      configuration: AliceConfiguration(
        showNotification: false,
        showInspectorOnShake: false,
        notificationIcon: '@mipmap/ic_launcher',
      ),
    );
    _alice?.addAdapter(aliceDioAdapter);
    return _alice!;
  }

  void initializeWithNavigator(GlobalKey<NavigatorState> navigatorKey) {
    alice.setNavigatorKey(navigatorKey);
    // Попробуем показать уведомление принудительно для отладки
    _tryShowNotification();
  }

  void _tryShowNotification() {
    // Создаем тестовый запрос для показа уведомления Alice
    Future.delayed(const Duration(seconds: 2), () {
      // Alice должна показать уведомление если есть активные вызовы
      print('Alice notification should be visible now');
    });
  }

  AliceDioAdapter get aliceDioAdapter {
    if (_aliceChopperAdapter != null) return _aliceChopperAdapter!;
    _aliceChopperAdapter = AliceDioAdapter();
    return _aliceChopperAdapter!;
  }
}
