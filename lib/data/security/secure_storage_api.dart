import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageApi {
  static const FlutterSecureStorage _box = FlutterSecureStorage();

  static Future<void> setAccessToken(String? value) async {
    await _box.write(key: 'access_token', value: value);
  }

  static Future<String?> getAccessToken() async {
    return await _box.read(key: 'access_token');
  }

  static Future<void> setRefreshToken(String? value) async {
    await _box.write(key: 'refresh_token', value: value);
  }

  static Future<String?> getRefresherToken() async {
    return await _box.read(key: 'refresh_token');
  }

  static Future<bool> isUserLoggedIn() async {
    final uid = await getRefresherToken();

    return uid != null;
  }
}
