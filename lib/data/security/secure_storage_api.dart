import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madrasati/data/errors/internal_exception.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

class SecureStorageApi {
  final FlutterSecureStorage _secureStorage;
  static final SecureStorageApi _instance = SecureStorageApi();
  static final  SecureStorageApi secureStorageApi = _instance;

  SecureStorageApi({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  Future<void> setAccessToken(String? value) async {
    try {
      await _secureStorage.write(key: _accessTokenKey, value: value);
    } catch (e) {
      logError('Error storing access token: $e');
      throw InternalException('Error storing access token in secure storage');
    }
  }

  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: _accessTokenKey);
    } catch (e) {
      logError('Error reading access token: $e');
      throw InternalException('Error reading access token in secure storage');
    }
  }

  Future<void> setRefreshToken(String? value) async {
    try {
      await _secureStorage.write(key: _refreshTokenKey, value: value);
    } catch (e) {
      logError('Error storing refresh token: $e');
      throw InternalException('Error storing refresh token in secure storage');
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _refreshTokenKey);
    } catch (e) {
      logError('Error reading refresh token: $e');
      throw InternalException('Error reading refresh token in secure storage');
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final refreshToken = await getRefreshToken();
      return refreshToken != null;
    } catch (e) {
      logError('Error checking login status: $e');
      throw InternalException('Error checking login status in secure storage');
    }
  }

  Future<void> logout() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      logError('Error during logout: $e');
      throw InternalException('Error during logout in secure storage');
    }
  }
}
