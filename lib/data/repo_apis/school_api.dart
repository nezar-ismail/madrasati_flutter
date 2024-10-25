import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/api_constant.dart';

class SchoolApi {
  final API api;

  SchoolApi(this.api);

  Future<Response> getAllSchools(
      {required int page, required int size, required String token}) async {
    String url = SchoolEndpoints.getAllSchools(page, size);
    log('url: $url');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    log('school api response:${response.data}');
    return response;
  }

  Future<Response> getSchoolById(
      {required String token, required String schoolId}) async {
    String url = SchoolEndpoints.getSchoolById(schoolId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    return response;
  }

  Future<Response> uploadCoverImage(
      {required String schoolId,
      required MultipartFile file,
      required String token}) async {
    String url = SchoolEndpoints.uploadCoverImage(schoolId);
    Map<String, String> authHeader = makeHeaders(token);
    final body = FormData.fromMap({
      'file': file,
    });

    Response response = await api.post(url, body: body, headers: authHeader);
    return response;
  }

  Future<Response> uploadSchoolImages(
      {required String schoolId,
      required List<MultipartFile> files,
      required String token}) async {
    String url = SchoolEndpoints.uploadSchoolImages(schoolId);
    Map<String, String> authHeader = makeHeaders(token);
    final body = FormData.fromMap({
      'files': files,
    });

    Response response = await api.post(url, body: body, headers: authHeader);
    return response;
  }

  Map<String, String> makeHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }
}