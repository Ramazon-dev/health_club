import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  Future<bool> removeAuthentication() async {
    final shared = await SharedPreferences.getInstance();
    Future.wait([
      shared.remove('accessToken'),
      shared.remove('refreshToken'),
    ]);
    return true;
  }

  Future<void> setLang(String lang) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('lang', lang);
  }

  Future<void> setAccessToken(String accessToken) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('accessToken', accessToken);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('refreshToken', refreshToken);
  }

  Future<void> setDeviceToken(String token) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('device_token', token);
  }

  Future<String> getLang(String lang) async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString('lang') ?? 'ru';
  }

  Future<String> getAccessToken() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString('accessToken') ?? '';
  }

  Future<String> getRefreshToken() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString('refreshToken') ?? '';
  }

  Future<String> getDeviceToken() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString('device_token') ?? '';
  }
}
