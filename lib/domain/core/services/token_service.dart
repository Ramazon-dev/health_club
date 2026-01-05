import 'package:dio/dio.dart';
import 'package:health_club/data/storage/app_storage.dart';

class TokenService {
  final AppStorage _storage;
  final Dio _dio;

  TokenService(this._storage, this._dio);

  /// Получить текущий access token
  Future<String?> get accessToken async {
    final accessToken = await _storage.getAccessToken();
    // print('object fetch access token $accessToken');
    return accessToken;
  }

  /// Получить текущий refresh token
  Future<String?> get refreshToken async {
    final refreshToken = await _storage.getRefreshToken();
    return refreshToken;
  }

  /// Проверить, авторизован ли пользователь
  Future<bool> get isAuthenticated async {
    final token = await accessToken;
    return token != null && token.isNotEmpty;
  }

  /// Обновить access token через refresh token
  Future<bool> refreshAccessToken() async {
    try {
      final currentRefreshToken = await refreshToken;
      if (currentRefreshToken == null || currentRefreshToken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
        'refresh',
        options: Options(headers: {'Authorization': currentRefreshToken}),
      );

      print('object refreshTokenFunction response ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response.data['access_token'] as String?;
        final newRefreshToken = response.data['refresh_token'] as String?;
        print('object new access token $newAccessToken and $newRefreshToken');

        if (newAccessToken != null) {
          // Обновляем токены в локальном хранилище
          await _updateTokens(newAccessToken, newRefreshToken);
          return true;
        }
      } else {
        await _clearTokens();
      }
      return false;
    } catch (e) {
      print('token service: Ошибка при обновлении токена: $e');
      await _clearTokens();
      return false;
    }
  }

  /// Выход из системы (очистка токенов)
  Future<void> logout() async {
    await _clearTokens();
  }

  /// Обновить токены в локальном хранилище
  Future<void> _updateTokens(String newAccessToken, String? newRefreshToken) async {
    _storage.setAccessToken(newAccessToken);
    if (newRefreshToken != null) _storage.setRefreshToken(newRefreshToken);
  }

  /// Очистить все токены
  Future<void> _clearTokens() async {
    await _storage.removeAuthentication();
  }

  /// Сохранить новые токены (используется при логине)
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? lang,
  }) async {
    await _storage.setAccessToken(accessToken);
    await _storage.setRefreshToken(refreshToken);
    if (lang != null) await _storage.setLang(lang);
  }
}
