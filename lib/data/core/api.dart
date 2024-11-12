import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api_inspector.dart';


class API {
  final APIInspector apiInspector;

  // Initialize with Dio and APIInspector
  API(this.apiInspector);

  /// Get request (supports JSON)
  Future<Response> get(String url, {Map<String, dynamic>? headers}) async {
    try {
      apiInspector.logRequest(RequestOptions(path: url, headers: headers));
      final Response response = await apiInspector.dio.get(
        url,
        options: apiInspector.createOptions(headers: headers),
      );
      apiInspector.logResponse(response);
      return response;
    } on DioException catch (e) {
      final errorResponse = await apiInspector.handleError(e, e.requestOptions);
      if (errorResponse != null) {
        return errorResponse;
      }
      rethrow;
    }
  }

  /// Download an image (supports responseType.bytes)
  Future<Response> getImage(String url, {Map<String, dynamic>? headers}) async {
    try {
      apiInspector.logRequest(RequestOptions(path: url, headers: headers));
      final Response response = await apiInspector.dio.get(
        url,
        options: apiInspector.createOptions(
          headers: headers,
          isJson: false,
        ),
      );
      apiInspector.logResponse(response);
      return response;
    } on DioException catch (e) {
      final errorResponse = await apiInspector.handleError(e, e.requestOptions);
      if (errorResponse != null) {
        return errorResponse;
      }
      rethrow;
    }
  }

  /// Post request (supports JSON and multipart form data)
  Future<Response> post(
    String url, {
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    try {
      apiInspector.logRequest(RequestOptions(path: url, headers: headers, data: body));
      final Response response;

      if (body is FormData) {
        // Send multipart form data
        response = await apiInspector.dio.post(
          url,
          options: apiInspector.createOptions(headers: headers),
          data: body,
        );
      } else {
        // Send JSON body
        response = await apiInspector.dio.post(
          url,
          options: apiInspector.createOptions(headers: headers),
          data: body != null ? jsonEncode(body) : null,
        );
      }

      apiInspector.logResponse(response);
      return response;
    } on DioException catch (e) {
      final errorResponse = await apiInspector.handleError(e, e.requestOptions);
      if (errorResponse != null) {
        return errorResponse;
      }
      rethrow;
    }
  }

  /// Put request (supports JSON and multipart form data)
  Future<Response> put(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      apiInspector.logRequest(RequestOptions(path: url, headers: headers, data: body));
      final Response response;

      if (body is FormData) {
        // Send multipart form data
        response = await apiInspector.dio.put(
          url,
          options: apiInspector.createOptions(headers: headers),
          data: body,
        );
      } else {
        // Send JSON body
        response = await apiInspector.dio.put(
          url,
          options: apiInspector.createOptions(headers: headers),
          data: body != null ? jsonEncode(body) : null,
        );
      }

      apiInspector.logResponse(response);
      return response;
    } on DioException catch (e) {
      final errorResponse = await apiInspector.handleError(e, e.requestOptions);
      if (errorResponse != null) {
        return errorResponse;
      }
      rethrow;
    }
  }

  /// Put request for Image (multipart form data)
  Future<Response> putImage(String url, {Map<String, dynamic>? headers, Object? body}) async {
    try {
      apiInspector.logRequest(RequestOptions(path: url, headers: headers, data: body));
      final Response response = await apiInspector.dio.put(
        url,
        options: apiInspector.createOptions(headers: headers),
        data: body,
      );
      apiInspector.logResponse(response);
      return response;
    } on DioException catch (e) {
      final errorResponse = await apiInspector.handleError(e, e.requestOptions);
      if (errorResponse != null) {
        return errorResponse;
      }
      rethrow;
    }
  }

  /// Delete request (supports JSON)
  Future<Response> delete(String url, {Map<String, dynamic>? headers}) async {
    try {
      apiInspector.logRequest(RequestOptions(path: url, headers: headers));
      final Response response = await apiInspector.dio.delete(
        url,
        options: apiInspector.createOptions(headers: headers),
      );
      apiInspector.logResponse(response);
      return response;
    } on DioException catch (e) {
      final errorResponse = await apiInspector.handleError(e, e.requestOptions);
      if (errorResponse != null) {
        return errorResponse;
      }
      rethrow;
    }
  }
}
