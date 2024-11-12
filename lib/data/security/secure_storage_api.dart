import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:madrasati/data/errors/internal_exception.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

class SecureStorageApi {
  final FlutterSecureStorage _secureStorage;
  static final SecureStorageApi _instance = SecureStorageApi();
  static final  SecureStorageApi instance = _instance;
  
  SecureStorageApi({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  /// Stores the access token in secure storage.
  ///
  /// Takes a [String] value representing the access token and writes it to
  /// secure storage under the key `_accessTokenKey`. If an error occurs during
  /// this process, it logs the error and throws an [InternalException].
  Future<void> setAccessToken(String? value) async {
    try {
      await _secureStorage.write(key: _accessTokenKey, value: value);
    } catch (e) {
      logError('Error storing access token: $e');
      throw InternalException('Error storing access token in secure storage');
    }
  }

  /// Retrieves the access token from secure storage.
  ///
  /// Returns a [String] value representing the access token if it exists in
  /// secure storage, or `null` otherwise. If an error occurs during this
  /// process, it logs the error and throws an [InternalException].
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: _accessTokenKey);
    } catch (e) {
      logError('Error reading access token: $e');
      throw InternalException('Error reading access token in secure storage');
    }
  }

  /// Stores the refresh token in secure storage.
  ///
  /// Takes a [String] value representing the refresh token and writes it to
  /// secure storage under the key `_refreshTokenKey`. If an error occurs during
  /// this process, it logs the error and throws an [InternalException].
  Future<void> setRefreshToken(String? value) async {
    try {
      await _secureStorage.write(key: _refreshTokenKey, value: value);
    } catch (e) {
      logError('Error storing refresh token: $e');
      throw InternalException('Error storing refresh token in secure storage');
    }
  }

  /// Retrieves the refresh token from secure storage.
  ///
  /// Returns a [String] value representing the refresh token if it exists in
  /// secure storage, or `null` otherwise. If an error occurs during this
  /// process, it logs the error and throws an [InternalException].
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _refreshTokenKey);
    } catch (e) {
      logError('Error reading refresh token: $e');
      throw InternalException('Error reading refresh token in secure storage');
    }
  }

  /// Checks whether the user is currently logged in.
  ///
  /// Returns a [Future] containing a [bool] value indicating whether the user is
  /// currently logged in. If the user is logged in (i.e., a refresh token exists
  /// in secure storage), the returned value is `true`. Otherwise, the returned
  /// value is `false`. If an error occurs during this process, it logs the error
  /// and throws an [InternalException].
  Future<bool> isUserLoggedIn() async {
    try {
      final refreshToken = await getRefreshToken();
      return refreshToken != null;
    } catch (e) {
      logError('Error checking login status: $e');
      throw InternalException('Error checking login status in secure storage');
    }
  }

  /// Logs the user out by deleting all values from secure storage.
  ///
  /// If an error occurs during this process, it logs the error and throws an
  /// [InternalException].
  Future<void> logout() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      logError('Error during logout: $e');
      throw InternalException('Error during logout in secure storage');
    }
  }
}
