import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/api_constant.dart';

class AuthApi {
  final API api;

  AuthApi(this.api);

  Future<Response> studentSignIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    String url = AuthEndpoints.studentLogin;

    final Map<String, dynamic> header = makeHeaders(deviceId, false);

    final Map<String, dynamic> body = makeBody(email, password);

    Response response = await api.post(url, headers: header, body: body);
    return response;
  }

  Future<Response> schoolSignIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    String url = AuthEndpoints.schoolLogin;

    final Map<String, dynamic> header = makeHeaders(deviceId, false);

    final Map<String, dynamic> body = makeBody(email, password);

    Response response = await api.post(url, headers: header, body: body);
    return response;
  }

  Future<Response> guestSignIn({required String deviceId}) async {
    String url = AuthEndpoints.guestLogin;

    final Map<String, dynamic> header = makeHeaders(deviceId, false);

    Response response = await api.post(url, headers: header);
    return response;
  }

  Future<Response> guestSignOut({required String token}) async {
    String url = AuthEndpoints.guestLogout;

    final Map<String, dynamic> header = makeHeaders(token, true);

    Response response = await api.post(url, headers: header);
    return response;
  }

  Future<Response> logout({required String refreshToken}) async {
    String url = AuthEndpoints.userLogout;

    final Map<String, dynamic> header = makeHeaders(refreshToken, true);

    Response response = await api.post(url, headers: header);
    return response;
  }

  Future<Response> refreshToken({required String refreshToken}) async {
    String url = AuthEndpoints.refreshToken;

    final Map<String, dynamic> header = makeHeaders(refreshToken, true);

    Response response = await api.post(url, headers: header);

    return response;
  }

  Map<String, String> makeHeaders(String value, bool isToken) {
    if (isToken) {
      return {"refresher-token": value};
    }
    return {'device-id': value};
  }

  Map<String, dynamic> makeBody(String email, String password) {
    return {"userEmail": email, "password": password};
  }
}