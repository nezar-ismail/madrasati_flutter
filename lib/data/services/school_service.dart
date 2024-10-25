import 'package:dio/dio.dart';
import 'package:madrasati/data/models/school_models/schoolPage/school_profile_page.dart';
import 'package:madrasati/data/repo_apis/school_api.dart';
import 'package:madrasati/data/utils/custom_logs.dart';
import '../errors/global_exception.dart';
import '../models/common_response_model.dart';
import '../models/school_models/school_home_page_response.dart';

class SchoolService {
  final SchoolApi schoolApi;
  SchoolService(this.schoolApi);
  Future<ResponsModel> getAllSchools({
    required int page,
    required int size,
    required String token,
  }) async {
    try {
      final Response response =
          await schoolApi.getAllSchools(page: page, size: size, token: token);
      switch (response.statusCode) {
        case 200:
          final data = SchoolHomePage.fromMap(response.data['data']);
          if (data.empty) {
            return EmptyResponse();
          }
          return data;
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw Exception('[${response.statusCode}]. Failed to fetch schools.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

  Future<ResponsModel> getSchoolById(
      {required String schoolId, required String token}) async {
    try {
      final Response response =
          await schoolApi.getSchoolById(schoolId: schoolId, token: token);
      switch (response.statusCode) {
        case 200:
          return SchoolProfilepage.fromMap(response.data['data']);
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

  Future<ResponsModel> uploadCoverImage(
      {required String schoolId,
      required MultipartFile file,
      required String token}) async {
    try {
      final Response response = await schoolApi.uploadCoverImage(
          schoolId: schoolId, file: file, token: token);
      switch (response.statusCode) {
        case 201:
          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw Exception(
              '[${response.statusCode}]. Failed to upload cover image.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

  Future<ResponsModel> uploadSchoolImages(
      {required String schoolId,
      required List<MultipartFile> files,
      required String token}) async {
    try {
      final Response response = await schoolApi.uploadSchoolImages(
          schoolId: schoolId, files: files, token: token);
      switch (response.statusCode) {
        case 201:
          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw Exception(
              '[${response.statusCode}]. Failed to upload school images.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }
}
//TODO: we need to handle the exception from server and front 
//TODO: determine the way to handle the data from server and choose the method 
//TODO: Make utils for file and enum for sorting and other to handle the request