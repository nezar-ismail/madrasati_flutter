import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/utils/device_id.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  
  final AuthService _authService = getIt<AuthService>();


  /// Calls [_authService.studentSignIn] with the given [email], [password], and the
  /// device id, and emits [SignInSuccess] if the response is an [EmptyResponse],
  /// [SignInUnAuthorized] if the response is an [UnAuthorizedResponse], and
  /// [SignInError] if the response is neither an [EmptyResponse] nor an
  /// [UnAuthorizedResponse].
  ///
  /// If the call to [_authService.studentSignIn] throws, logs the error and
  /// emits [SignInError].
  Future<void> studentSignIn({required String email, required String password}) async {
    emit(SignInLoading());
    try {
      ResponsModel responsModel = await _authService.studentSignIn(email: email, password: password, deviceId: await getDeviceId()??"" );
      if(responsModel is EmptyResponse){
        emit(SignInSuccess());
      }else if(responsModel is UnAuthorizedResponse){
        emit(SignInUnAuthorized(message: 'Invalid credentials'));
      }else{
        emit(SignInError(message: 'Something went wrong'));}
      
    } catch (e) {
      emit(SignInError(message: 'Something went wrong'));
    }
  }

  /// Calls [_authService.schoolSignIn] with the provided [email], [password], and the
  /// device id, and emits [SignInSuccess] if the response is an [EmptyResponse],
  /// [SignInUnAuthorized] if the response is an [UnAuthorizedResponse], and
  /// [SignInError] if the response is neither an [EmptyResponse] nor an
  /// [UnAuthorizedResponse].
  ///
  /// If the call to [_authService.schoolSignIn] throws, logs the error and
  /// emits [SignInError].
    Future<void> schoolSignIn({required String email, required String password}) async {
    emit(SignInLoading());
    try {
      ResponsModel responsModel = await _authService.schoolSignIn(email: email, password: password, deviceId: await getDeviceId()??"" );
      if(responsModel is EmptyResponse){
        emit(SignInSuccess());
      }else if(responsModel is UnAuthorizedResponse){
        emit(SignInUnAuthorized(message: 'Invalid credentials'));
      }else{
        emit(SignInError(message: 'Something went wrong'));}
      
    } catch (e) {
      emit(SignInError(message: 'Something went wrong'));
    }
  }

  /// Calls [_authService.guestSignIn] with the device id and emits [SignInSuccess]
  /// if the response is an [EmptyResponse], [SignInUnAuthorized] if the response
  /// is an [UnAuthorizedResponse], and [SignInError] if the response is neither
  /// an [EmptyResponse] nor an [UnAuthorizedResponse].
  ///
  /// If the call to [_authService.guestSignIn] throws, logs the error and emits
  /// [SignInError].
      Future<void> guestSignIn() async {
    emit(SignInLoading());
    try {
      ResponsModel responsModel = await _authService.guestSignIn(deviceId: await getDeviceId()??"" );
      if(responsModel is EmptyResponse){
        emit(SignInSuccess());
      }else if(responsModel is UnAuthorizedResponse){
        emit(SignInUnAuthorized(message: 'Invalid credentials'));
      }else{
        emit(SignInError(message: 'Something went wrong'));}
      
    } catch (e) {
      emit(SignInError(message: 'Something went wrong'));
    }
  }
}