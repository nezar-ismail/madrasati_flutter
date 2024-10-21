// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'api_constant.dart';

class API {
  final Dio dio;
  API(this.dio);

  String get baseUrl => BaseUrl.baseUrl;

  // Options 
  Options jsonOptions = Options(
    headers: {'Content-type': 'application/json; charset=UTF-8'},
    responseType: ResponseType.json,
  );

  Options formOptions = Options(
    headers: {'Content-type': 'multipart/form-data'},
    responseType: ResponseType.json,
  );

  /// General request 
  Future<Response> _request(
    String method, 
    String url, {
    Map<String, dynamic>? headers,
    Object? body,
    bool isFormData = false,
  }) async {
    String urlRequest = '$baseUrl/$url';
    Options options = isFormData ? formOptions : jsonOptions;

    try {
      Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await dio.get(
            urlRequest,
            options: options.copyWith(headers: headers),
          );
          break;
        case 'POST':
          response = await dio.post(
            urlRequest,
            options: options.copyWith(headers: headers),
            data: body != null ? (isFormData ? body : jsonEncode(body)) : null,
          );
          break;
        case 'PUT':
          response = await dio.put(
            urlRequest,
            options: options.copyWith(headers: headers),
            data: body != null ? (isFormData ? body : jsonEncode(body)) : null,
          );
          break;
        case 'DELETE':
          response = await dio.delete(
            urlRequest,
            options: options.copyWith(headers: headers),
          );
          break;
        default:
          throw UnsupportedError('Unsupported method: $method');
      }

      return response;
    } on DioException catch (e) {
      log('DioError: ${e.message}');
      log('Response data: ${e.response?.data}');
      if (e.response == null) rethrow;
      return e.response!;
    }
  }

  /// GET request
  Future<Response> get(String url, {Map<String, String>? headers}) async {
    return _request('GET', url, headers: headers);
  }

  /// POST request
  Future<Response> post(
    String url, {
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    bool isFormData = body is FormData;
    return _request('POST', url, headers: headers, body: body, isFormData: isFormData);
  }

  /// PUT request
  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return _request('PUT', url, headers: headers, body: body);
  }

  /// PUT image (specifically for handling multipart/form-data requests)
  Future<Response> putImage(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    return _request('PUT', url, headers: headers, body: body, isFormData: true);
  }

  /// DELETE request
  Future<Response> delete(String url, {Map<String, String>? headers}) async {
    return _request('DELETE', url, headers: headers);
  }
}
