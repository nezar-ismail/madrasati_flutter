import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:madrasati/data/errors/internal_exception.dart';
import 'package:madrasati/data/hive/school/s_manger_box.dart';
import 'package:madrasati/data/hive/school/s_manger_field.dart';
import 'package:madrasati/data/hive/student/student_box.dart';
import 'package:madrasati/data/hive/student/student_feild.dart';
import 'package:madrasati/data/repo_apis/authentication_api.dart';
import '../errors/global_exception.dart';
import '../models/common_response_model.dart';
import '../security/secure_storage_api.dart';
import '../utils/custom_logs.dart';

class AuthService {
  final AuthApi _authApi;
  final SecureStorageApi _secureStorage;
  AuthService(this._authApi, this._secureStorage);

  /// Calls [_authApi.studentSignIn] with the given [email], [password], and [deviceId],
  /// and saves the received data in Hive.
  ///
  /// Throws [GlobalException] if the server returns an error, and
  /// [InternalException] if there is an error in the function.
  Future<ResponsModel> studentSignIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    try {
      final Response response = await _authApi.studentSignIn(
          email: email, password: password, deviceId: deviceId);
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'] as Map<String, dynamic>;
          _secureStorage.setAccessToken(data['accessToken']);
          _secureStorage.setRefreshToken(data['token']);

          // Create a Student object and save it in Hive
          final student = LocalStudent(
            userEmail: data['user']['userEmail'],
            firstName: data['user']['userFirstName'],
            lastName: data['user']['userLastName'],
            imagePath: data['user']['userImage'],
            birthDate: data['user']['userBirthDate'],
            gender: data['user']['userGender'],
            schoolId: data['data']['school'],
            groupId: data['data']['group'],
            studentId: data['userId'],
            schoolName: data['data']['schoolName'],
          );

          log('Service: schoolSignIn: $student');
          // Save student data to Hive
          await UserBox.saveUser(student);

          return EmptyResponse();
        case 401:
          return UnAuthorizedResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("there is an error in login");
      }
    } catch (e) {
      logError("AuthService:studentSignIn: $e");
      rethrow;
    }
  }

  /// Calls [_authApi.schoolSignIn] with the given [email], [password], and the
  /// device id, and emits [SignInSuccess] if the response is an [EmptyResponse],
  /// [SignInUnAuthorized] if the response is an [UnAuthorizedResponse], and
  /// [SignInError] if the response is neither an [EmptyResponse] nor an
  /// [UnAuthorizedResponse].
  ///
  /// If the call to [_authApi.schoolSignIn] throws, logs the error and
  /// emits [SignInError].
  ///
  /// Saves the school manager data to Hive.
  Future<ResponsModel> schoolSignIn(
      {required String email,
      required String password,
      required String deviceId}) async {
    try {
      final Response response = await _authApi.schoolSignIn(
          email: email, password: password, deviceId: deviceId);
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'] as Map<String, dynamic>;
          _secureStorage.setAccessToken(data['accessToken']);
          _secureStorage.setRefreshToken(data['token']);
          final school = LocalSchoolManger(
            userEmail: data['user']['userEmail'],
            firstName: data['user']['userFirstName'],
            lastName: data['user']['userLastName'],
            imagePath: data['data']['school']['schoolCoverImage'],
            birthDate: data['user']['userBirthDate'],
            gender: data['user']['userGender'],
            schoolId: data['data']['school']['schoolId'],
            groupId: data['groupId'],
            
          );
          // Save student data to Hive
          await SMangerBox.saveUser(school);
          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("there is an error in login");
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

/// Logs out the user by calling the [_authApi.logout] with the provided [refreshToken].
///
/// Clears the secure storage if the logout is successful.
///
/// Returns an [EmptyResponse] if the server responds with a 204 status code.
///
/// Throws [GlobalException] if the server returns an error response, 
/// and [InternalException] if there is any error during the logout process.
  Future<ResponsModel> logout({required String refreshToken}) async {
    final Response response = await _authApi.logout(refreshToken: refreshToken);
    switch (response.statusCode) {
      case 204:
        await _secureStorage.logout();
        return EmptyResponse();
      default:
        if (response.data is Map<String, dynamic>) {
          throw GlobalException.fromResponse(response);
        }
        throw InternalException("there is an error in logout");
    }
  }

  /// Calls [_authApi.guestSignIn] with the given [deviceId] and saves the received access token and refresh token in the secure storage.
  ///
  /// Returns an [EmptyResponse] if the server responds with a 200 status code.
  ///
  /// Throws [GlobalException] if the server returns an error response, 
  /// and [InternalException] if there is any error during the guest sign in process.
  Future<ResponsModel> guestSignIn({required String deviceId}) async {
    try {
      final Response response = await _authApi.guestSignIn(deviceId: deviceId);
      switch (response.statusCode) {
        case 200:
          final data = response.data['data'] as Map<String, dynamic>;
          _secureStorage.setAccessToken(data['accessToken']);
          _secureStorage.setRefreshToken(data['token']);

          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("there is an error in login");
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

  /// Calls [_authApi.guestSignOut] with the given [token] and logs out the guest user from the app.
  ///
  /// Returns an [EmptyResponse] if the server responds with a 204 status code.
  ///
  /// Throws [GlobalException] if the server returns an error response, and
  /// [InternalException] if there is any error during the guest sign out process.
  Future<ResponsModel> guestSignOut({required String token}) async {
    try {
      final Response response = await _authApi.guestSignOut(token: token);
      switch (response.statusCode) {
        case 204:
          await _secureStorage.logout();
          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("there is an error in logout");
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

  /// Calls [_authApi.refreshToken] with the given [refreshToken] and saves the new
  /// access token in the secure storage.
  ///
  /// Returns an [EmptyResponse] if the server responds with a 200 status code.
  ///
  /// Throws [GlobalException] if the server returns an error response, and
  /// [InternalException] if there is any error during the refresh token process.
  Future<ResponsModel> refreshToken({required String refreshToken}) async {
    final Response response =
        await _authApi.refreshToken(refreshToken: refreshToken);
    switch (response.statusCode) {
      case 200:
        final data = response.data['data'] as Map<String, dynamic>;
        _secureStorage.setAccessToken(data['accessToken']);
        return EmptyResponse();
      default:
        if (response.data is Map<String, dynamic>) {
          throw GlobalException.fromResponse(response);
        }
        throw InternalException("there is an error in refresh token");
    }
  }

  /// Calls [_authApi.editPassword] with the given [oldPassword], [newPassword], and [token] and returns an [EmptyResponse] if the server responds with a 204 status code.
  ///
  /// Throws [GlobalException] if the server returns an error response, and
  /// [InternalException] if there is any error during the edit password process.
  Future<ResponsModel> editPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    try {
      final Response response = await _authApi.editPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        token: token,
      );
      switch (response.statusCode) {
        case 204:
          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("there is an error in edit password");
      }
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }

}
