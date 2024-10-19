import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';

class AuthApi {
  final API api;

  AuthApi(this.api);

  Future<Response> signIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    String url = makeAuthUrl('login');
    final Map<String, dynamic> header = {'device-id': deviceId};

    final Map<String, dynamic> body = {
      "userEmail": email,
      "password": password
    };
    Response response = await api.post(url, headers: header, body: body);
    return response;
  }

  Future<Response> logout({required String refreshToken}) async {
    String url = makeAuthUrl('logout');
    final Map<String, dynamic> header = {'refresher-token': refreshToken};

    Response response = await api.post(url, headers: header);
    return response;
  }

  Future<Response> refreshToken({required String refreshToken}) async {
    String url = makeAuthUrl('token');
    final Map<String, dynamic> header = {'refresher-token': refreshToken};
    Response response = await api.post(url, headers: header);

    return response;
  }
}

String makeAuthUrl(String endPoint) {
  return 'v1/auth/$endPoint';
}
