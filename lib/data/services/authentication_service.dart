import 'package:dio/dio.dart';
import 'package:madrasati/data/models/auth_models/user.dart';
import 'package:madrasati/data/repo_apis/authentication_api.dart';

import '../utils/custom_logs.dart';

class AuthService {
  final AuthApi _authApi;
  AuthService(this._authApi);

  Future<Response> signIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    try {
      final Response response = await _authApi.signIn(
          email: email, password: password, deviceId: deviceId);
      switch (response.statusCode) {
        case 200:
          final data = response.data['user'] as Map<String, dynamic>;
          User user = User.fromMap(data);
          return response;
        default:
          return response;
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

  Future<Response> logout({required String refreshToken}) async {
    return await _authApi.logout(refreshToken: refreshToken);
  }

  Future<Response> refreshToken({required String refreshToken}) async {
    return await _authApi.refreshToken(refreshToken: refreshToken);
  }
}
