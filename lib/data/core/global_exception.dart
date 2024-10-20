import 'package:dio/dio.dart';

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

  static GlobalException fromRespone(Response response) {
    final String message =
        response.data['message'] ?? 'An unknown error occurred.';
    final String error = response.data['error'] ?? 'unknown';
    final int? statusCode = response.statusCode;

    return GlobalException(
      message: message,
      error: error,
      statusCode: statusCode,
    );
  }
}
