import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wellness/core/networking/api_constants.dart';

class TokenManager {
  static final _storage = FlutterSecureStorage();
  static const _accessKey = ApiConstants.accessToken;
  static const _refreshKey = ApiConstants.refreshToken;

  static Future<String?> getAccessToken() => _storage.read(key: _accessKey);
  static Future<String?> getRefreshToken() => _storage.read(key: _refreshKey);

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }

  static Future<void> updateAccessToken(String accessToken) =>
      _storage.write(key: _accessKey, value: accessToken);

  static Future<void> clearTokens() async {
    await _storage.deleteAll();
  }
}