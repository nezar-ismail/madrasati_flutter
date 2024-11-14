import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/models/auth_models/token.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/utils/custom_logs.dart';
import 'package:madrasati/main.dart';
import 'package:madrasati/presintation/core/utils/common_func.dart';
import 'package:madrasati/presintation/phone/features/sign_in/role_desesion.dart';

class APIInspector {
  final Dio dio;

  APIInspector(this.dio);

  bool _isRefreshing = false;

  Options createOptions({
    Map<String, dynamic>? headers,
    bool isJson = true,
    bool isToken = true,
    String? token,
    bool isMultipart = false,
    Duration? receiveTimeout = const Duration(seconds: 30),
    Duration? sendTimeout = const Duration(seconds: 30),
  }) {
    headers = headers ?? {};
    if (isToken && token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return Options(
      headers: headers,
      responseType: isJson ? ResponseType.json : ResponseType.bytes,
      contentType: isMultipart ? "multipart/form-data" : "application/json",
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  /// Handles a [DioException] by attempting to refresh the access token
  /// when the status code is 401 and retrying the original request with
  /// the new access token. If the refresh token is expired or failed,
  /// it signs out the user and navigates to the login screen.
  Future<Response?> handleError(
      DioException e, RequestOptions requestOptions) async {
    if (e.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refresherToken =
            await SecureStorageApi.instance.getRefreshToken();
        final refreshedToken = await getIt<AuthService>()
            .refreshToken(refreshToken: refresherToken!);
        final newOptions = createOptions(
          headers: {
            ...requestOptions.headers,
            "Authorization":
                "Bearer ${refreshedToken is AccessTokenModel ? refreshedToken.accessToken : ""}",
          },
        );
        logInfo('Token refreshed successfully');
        if (requestOptions.data is FormData) {
          final formData = requestOptions.data as FormData;
          return await dio.request(
            requestOptions.path,
            options: newOptions,
            data: formData,
            queryParameters: requestOptions.queryParameters,
          );
        } else {
          return await dio.request(
            requestOptions.path,
            options: newOptions,
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );
        }
      } catch (error) {
        await _handleTokenExpiration();
      } finally {
        _isRefreshing = false;
      }
    }
    return e.response;
  }

  /// Handles token expiration by clearing session data, redirecting the user
  /// to the sign-in page, and displaying a session expiration message.
  Future<void> _handleTokenExpiration() async {
    try {
      await SecureStorageApi.instance.logout();
      if (navigatorKey.currentState?.canPop() == true) {
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => RoleDesesion()),
          (Route<dynamic> route) => false,
        );
      }
      final overlayState = navigatorKey.currentState?.overlay;
      if (overlayState != null) {
        final message = 'Session expired, Please login again';
        final icon = Icons.error;
        final color = Colors.red;
        customSnackbar(overlayState, message, icon, color);
      }
    } catch (e) {
      rethrow;
    }
  }
}
