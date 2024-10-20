// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';

import '../models/common_response_model.dart';

class GlobalException implements Exception {
  final String message;
  final int? statusCode;
  final String? error;

  GlobalException({
    this.message = 'An unknown error occurred.',
    this.error = 'unknown',
    this.statusCode,
  });

  @override
  String toString() => '[$statusCode].$message. Error : $error';

  // Factory method to return appropriate response type based on status code
  static ResponsModel fromResponse(Response response) {
    final String message =
        response.data['message'] ?? 'An unknown error occurred.';
    final String error = response.data['error'] ?? 'unknown';
    final int? statusCode = response.statusCode;

    if (response.statusCode == 401) {
      return UnAuthorizedResponse();
    } else if (response.statusCode == 400) {
      List<String> listErrors = [];
      if (response.data['errors'] != null) {
        (response.data['errors'] as Map<String, dynamic>).forEach((key, value) {
          if (value is List) {
            listErrors.addAll(value.map((e) => '$key: $e').toList());
          } else {
            listErrors.add('$key: $value');
          }
        });
      }
      return BadRequestResponse(listErrors: listErrors);
    } else if (response.statusCode == 500) {
      return ServerErrorResponse();
    } else if (response.statusCode == 204) {
      return EmptyResponse();
    } else {
      return ServerErrorResponse();
    }
  }
}
