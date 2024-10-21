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
    String url = AuthEndpoints.schoolLogin;
    final Map<String, dynamic> header = {'device-id': deviceId};
    final Map<String, dynamic> body = {
      "userEmail": email,
      "password": password
    };
    Response response = await api.post(url, headers: header, body: body);
    return response;
  }

  Future<Response> schoolSignIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    String url = AuthEndpoints.schoolLogin;
    final Map<String, dynamic> header = {'device-id': deviceId};

    final Map<String, dynamic> body = {
      "userEmail": email,
      "password": password
    };
    Response response = await api.post(url, headers: header, body: body);
    return response;
  }

  Future<Response> guestSignIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    String url = AuthEndpoints.guestLogin;
    final Map<String, dynamic> header = {'device-id': deviceId};

    final Map<String, dynamic> body = {
      "userEmail": email,
      "password": password
    };
    Response response = await api.post(url, headers: header, body: body);
    return response;
  }

  Future<Response> logout({required String refreshToken}) async {
    String url = AuthEndpoints.userLogout;
    final Map<String, dynamic> header = {'refresher-token': refreshToken};

    Response response = await api.post(url, headers: header);
    return response;
  }

  Future<Response> refreshToken({required String refreshToken}) async {
    String url = AuthEndpoints.refreshToken;
    final Map<String, dynamic> header = {'refresher-token': refreshToken};
    Response response = await api.post(url, headers: header);

    return response;
  }
}
