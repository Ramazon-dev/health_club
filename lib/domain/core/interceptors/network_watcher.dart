import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

enum NetStatus {
  online,
  offline,
}

class NetworkWatcher {
  final Dio _probeDio;
  final String _probeUrl;
  final _controller = StreamController<NetStatus>.broadcast();

  Stream<NetStatus> get stream => _controller.stream;
  NetStatus _sate = NetStatus.online;

  NetworkWatcher(this._probeDio, this._probeUrl);

  Future<void> init() async {
    await _probe();
    Connectivity().onConnectivityChanged.listen((_) => _probe());
  }

  Future<void> _probe() async {
    try {
      await _probeDio.get(
        _probeUrl,
        options: Options(method: "GET", receiveTimeout: const Duration(seconds: 3)),
      );
      _set(NetStatus.online);
    } catch (e) {
      _set(NetStatus.offline);
    }
  }

  void _set(NetStatus s) {
    if (_sate != s) {
      _sate = s;
      _controller.add(s);
    }
  }

  Future<void> checkNow() => _probe();

  bool get isOnline => _sate == NetStatus.online;

  void dispose() => _controller.close();
}
