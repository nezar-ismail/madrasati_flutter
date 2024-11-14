import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/api_constant.dart';

class SchoolApi {
  final API api;

  SchoolApi(this.api);

  /// Fetches a list of schools from the server with pagination.
  ///
  /// [page] specifies the page number to be fetched.
  /// [size] determines the number of schools per page.
  /// [token] is the authentication token for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the list of schools
  /// if the request is successful. Logs the request URL and response data for debugging.
  Future<Response> getAllSchools(
      {required int page, required int size, required String token}) async {
    String url = SchoolEndpoints.getAllSchools(page, size);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    return response;
  }

  /// Fetches the school with the specified [schoolId] from the server.
  ///
  /// [schoolId] is the identifier for the school to be fetched.
  /// [token] is the authentication token for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the school data
  /// if the request is successful. Logs the request URL and response data for
  /// debugging.
  Future<Response> getSchoolById(
      {required String token, required String schoolId}) async {
    String url = SchoolEndpoints.getSchoolById(schoolId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    return response;
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

  /// Fetches all feedbacks for a specified school.
  ///
  /// [schoolId] is the identifier for the school whose feedbacks are to be fetched.
  /// [token] is the authentication token required for the API request.
  /// [page] is the page number for pagination.
  /// [size] indicates the number of feedbacks to fetch per page.
  ///
  /// Returns a [Future] containing the server [Response] with the feedbacks data if the request is successful.
  /// Throws an exception if the request fails.
  Future<Response> getAllFeedbacks(
      {required String schoolId,
      required String token,
      required int page,
      required int size}) async {
    String url = SchoolEndpoints.getAllFeedbacks(page, size, schoolId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    return response;
  }

  /// Constructs a map of headers for API requests, given a Bearer
  /// authentication [token].
  ///
  /// The headers include an 'Authorization' header containing the provided
  /// [token] in Bearer token format.
  ///
  /// Returns a [Map<String, String>] containing the headers for the request.
  Map<String, String> makeHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }
}
