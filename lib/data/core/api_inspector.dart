import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api_constant.dart';
import 'package:madrasati/data/errors/global_exception.dart';
import 'package:madrasati/data/errors/internal_exception.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

class APIInspector {
  final Dio dio;

  APIInspector(this.dio);

  /// Logs request details.
  void logRequest(RequestOptions options) {
    log('Request: [${options.method}] ${options.path}');
    log('Headers: ${options.headers}');
    if (options.data != null) log('Data: ${options.data}');
  }

  /// Logs response details.
  void logResponse(Response response) {
    log('Response: [${response.statusCode}] ${response.requestOptions.path}');
  }

  /// Creates a [Options] object with default headers containing the
  /// authorization bearer token and optional custom headers.
  Options createOptions({Map<String, dynamic>? headers, bool isJson = true, bool isToken = true}) {
    return Options(
      headers: headers,
      responseType: isJson ? ResponseType.json : ResponseType.bytes,
    );
  }

  /// Handles Dio errors, retrying the request if the error is a 401
  /// unauthorized response. If the retry fails, the original error
  /// response is returned.
  Future<Response?> handleError(
      DioException e, RequestOptions requestOptions) async {
    if (e.response?.statusCode == 401) {
      try {
        // Refresh token logic
        final refresherToken = await SecureStorageApi.instance.getRefreshToken();
        final refreshedToken = await refreshToken(refreshToken: refresherToken!);

        // Retry the original request with the new access token
        final newOptions = createOptions(
          headers: {
            ...requestOptions.headers,
            "Authorization": "Bearer ${refreshedToken.accessToken}"
          },
        );
        log('New options: ${newOptions.toString()}');
        logInfo( 'Token refreshed successfully');
        return await dio.request(
          requestOptions.path,
          options: newOptions,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
        );
      } catch (error) {
        log('Token refresh failed: $error');
      }
    }
    return e.response; // Return original error if not 401
  }

  /// Refreshes the access token using the provided refresh token.
  Future<AccessTokenModel> refreshToken({required String refreshToken}) async {
    final Response response = await refreshTokenApi(refreshToken: refreshToken);
    switch (response.statusCode) {
      case 200:
        final data = response.data['data'] as Map<String, dynamic>;
        final accessToken = data['accessToken'] as String;
        await SecureStorageApi.instance.setAccessToken(accessToken);
        return AccessTokenModel(accessToken: accessToken);
      default:
        if (response.data is Map<String, dynamic>) {
          throw GlobalException.fromResponse(response);
        }
        throw InternalException("There was an error in refreshing the token.");
    }
  }

  /// Sends a request to the API to refresh the token.
  Future<Response> refreshTokenApi({required String refreshToken}) async {
    String url = AuthEndpoints.refreshToken;

    final Map<String, dynamic> header = {"refresher-token": refreshToken};

    try {
      Response response = await dio.post(
        url,
        options: Options(
          headers: header,
          responseType: ResponseType.json,
          contentType: "application/json",
        ),
      );
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

/// Model for storing the access token.
class AccessTokenModel {
  final String accessToken;

  AccessTokenModel({required this.accessToken});
}
