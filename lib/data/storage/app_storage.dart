import 'package:health_club/data/network/model/user_country_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  Future<bool> removeAuthentication() async {
    final shared = await SharedPreferences.getInstance();
    Future.wait([
      shared.remove('accessToken'),
      shared.remove('refreshToken'),
      shared.remove('register'),
    ]);
    return true;
  }

  Future<void> setLang(String lang) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('lang', lang);
  }

  Future<void> setCountry(String country) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('country', country);
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

  Future<void> setRegister(bool register) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setBool('register', register);
  }

  Future<String> getLang(String lang) async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString('lang') ?? 'ru';
  }

  Future<bool> getRegister() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getBool('register') ?? false;
  }

  Future<String> getCountry() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString('country') ?? AppCountryEnum.uz.name;
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
