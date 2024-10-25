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
            firstName: data['user']['firstName'],
            lastName: data['user']['lastName'],
            imagePath: data['user']['imagePath'],
            birthDate: data['user']['birthDate'],
            gender: data['user']['gender'],
            
          );
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
          final student = LocalSManger(
            userEmail: data['userEmail'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            imagePath: data['imagePath'],
            birthDate: data['birthDate'],
            gender: data['gender'],
          );
          // Save student data to Hive
          await SMangerBox.saveUser(student);
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
}
