import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';

class SchoolApi {
  final API api;

  SchoolApi(this.api);

  Future<Response> getAllSchools(
      {required int page, required int size, required String token}) async {
    String url = makeSchoolUrl('getAllSchools?page=$page&size=$size');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    return response;
  }

  Future<Response> getSchoolById(
      {required String token, required String schoolId}) async {
    String url = makeSchoolUrl('getSchoolById/$schoolId');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    return response;
  }

  Future<Response> uploadCoverImage(
      {required String schoolId,
      required MultipartFile file,
      required String token}) async {
    String url = makeSchoolUrl('$schoolId/uploadCoverImage');
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
    String url = makeSchoolUrl('$schoolId/uploadSchoolImages');
    Map<String, String> authHeader = makeHeaders(token);
    final body = FormData.fromMap({
      'files': files,
    });

    Response response = await api.post(url, body: body, headers: authHeader);
    return response;
  }

  String makeSchoolUrl(String endPoint) {
    return 'v1/school/$endPoint';
  }

  Map<String, String> makeHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }
}
