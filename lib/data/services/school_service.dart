import 'package:dio/dio.dart';
import 'package:madrasati/data/errors/internal_exception.dart';
import 'package:madrasati/data/models/feedback/feedback_res.dart';
import 'package:madrasati/data/models/school_models/schoolPage/school_profile_page.dart';
import 'package:madrasati/data/repo_apis/school_api.dart';
import 'package:madrasati/data/utils/custom_logs.dart';
import '../errors/global_exception.dart';
import '../models/common_response_model.dart';
import '../models/school_models/school_home_page_response.dart';

class SchoolService {
  final SchoolApi schoolApi;
  SchoolService(this.schoolApi);
  
  /// Fetches a page of schools from the server with pagination.
  ///
  /// [page] specifies the page number to be fetched.
  /// [size] determines the number of schools per page.
  /// [token] is the authentication token for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the list of schools
  /// if the request is successful. Logs the request URL and response data for
  /// debugging.
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

  /// Fetches the school information for a given [schoolId] from the server.
  ///
  /// [schoolId] is the identifier of the school to be fetched.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing a [ResponsModel] which will be an instance
  /// of [SchoolProfilepage] if the request is successful.
  /// If the response status code is not 200, it throws an exception with the
  /// corresponding status code and error message.
  /// Logs any errors encountered during the request.
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

  /// Uploads the cover image for a school with the specified [schoolId].
  ///
  /// [schoolId] is the identifier for the school to which the cover image is
  /// being uploaded.
  /// [file] is the image file to be uploaded.
  /// [token] is the authentication token for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the upload
  /// status if the request is successful. Logs the request URL and response
  /// data for debugging.
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

  /// Uploads the images for a school with the specified [schoolId].
  ///
  /// [schoolId] is the identifier for the school to which the images are
  /// being uploaded.
  /// [files] is the list of image files to be uploaded.
  /// [token] is the authentication token for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the upload
  /// status if the request is successful. Logs the request URL and response
  /// data for debugging.
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


Future<ResponsModel> getAllComments({
    required String schoolId,
    required String token,
    required int page,
    required int size,
  }) async {
    try {
      Response response = await schoolApi.getAllFeedbacks(
        schoolId: schoolId,
        token: token,
        page: page,
        size: size,
      );
      switch (response.statusCode) {
        case 200:
          final data = FeedbackData.fromMap(response.data['data']);
          if (data.empty) {
            return EmptyResponse();
          }
          return data;
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("Failed to fetch posts");
      }
    } catch (e) {
      logError('error with getAllPosts $e');
      rethrow;
    }
  }



}
//TODO: we need to handle the exception from server and front 
//TODO: determine the way to handle the data from server and choose the method 
//TODO: Make utils for file and enum for sorting and other to handle the request