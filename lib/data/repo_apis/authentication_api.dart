import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/api_constant.dart';

class AuthApi {
  final API api;

  AuthApi(this.api);

  Future<Response> signIn({
    required String email,
    required String password,
    required String deviceId,
    bool isSchoolSignIn = false,
  }) async {
    String url = isSchoolSignIn ? AuthEndpoints.schoolLogin : AuthEndpoints.studentLogin;
    final Map<String, dynamic> header = makeHeaders(deviceId, false);
    final Map<String, dynamic> body = makeBody(email, password);

    return await _postRequest(url: url, headers: header, body: body);
  }

  Future<Response> guestSignIn({required String deviceId}) async {
    String url = AuthEndpoints.guestLogin;
    final Map<String, dynamic> header = makeHeaders(deviceId, false);

    return await _postRequest(url: url, headers: header);
  }

  Future<Response> guestSignOut({required String token}) async {
    String url = AuthEndpoints.guestLogout;
    final Map<String, dynamic> header = makeHeaders(token, true);

    return await _postRequest(url: url, headers: header);
  }

  Future<Response> logout({required String refreshToken}) async {
    String url = AuthEndpoints.userLogout;
    final Map<String, dynamic> header = makeHeaders(refreshToken, true);

    return await _postRequest(url: url, headers: header);
  }

  Future<Response> refreshToken({required String refreshToken}) async {
    String url = AuthEndpoints.refreshToken;
    final Map<String, dynamic> header = makeHeaders(refreshToken, true);

    return await _postRequest(url: url, headers: header);
  }

  /// Centralized POST request handling
  Future<Response> _postRequest({
    required String url,
    required Map<String, dynamic> headers,
    Map<String, dynamic>? body,
  }) async {
    return await api.post(url, headers: headers, body: body);
  }

  /// Creates headers based on whether it's a token or a device ID
  Map<String, String> makeHeaders(String value, bool isToken) {
    return isToken ? {"refresher-token": value} : {'device-id': value};
  }

  /// Constructs the body for sign-in requests
  Map<String, dynamic> makeBody(String email, String password) {
    return {"userEmail": email, "password": password};
  }
}
