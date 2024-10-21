


import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/utils/device_id.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.responsModel, this._authService) : super(SignInInitial());

  late ResponsModel responsModel ;
  final AuthService _authService;


  Future<void> studentSignIn({required String email, required String password}) async {
    emit(SignInLoading());
    try {
      responsModel = await _authService.studentSignIn(email: email, password: password, deviceId: await getDeviceId()??"" );
      if(responsModel is EmptyResponse){
        emit(SignInSuccess());
      }else if(responsModel is UnAuthorizedResponse){
        emit(SignInUnAuthorized(message: 'Invalid credentials'));
      }else{
        emit(SignInError(message: 'Something went wrong'));}
      
    } catch (e) {
      log(e.toString());
      emit(SignInError(message: 'Something went wrong'));
    }
  }

    Future<void> schoolSignIn({required String email, required String password}) async {
    emit(SignInLoading());
    try {
      responsModel = await _authService.schoolSignIn(email: email, password: password, deviceId: await getDeviceId()??"" );
      if(responsModel is EmptyResponse){
        emit(SignInSuccess());
      }else if(responsModel is UnAuthorizedResponse){
        emit(SignInUnAuthorized(message: 'Invalid credentials'));
      }else{
        emit(SignInError(message: 'Something went wrong'));}
      
    } catch (e) {
      log(e.toString());
      emit(SignInError(message: 'Something went wrong'));
    }
  }

      Future<void> guestSignIn({required String email, required String password}) async {
    emit(SignInLoading());
    try {
      responsModel = await _authService.guestSignIn(deviceId: await getDeviceId()??"" );
      if(responsModel is EmptyResponse){
        emit(SignInSuccess());
      }else if(responsModel is UnAuthorizedResponse){
        emit(SignInUnAuthorized(message: 'Invalid credentials'));
      }else{
        emit(SignInError(message: 'Something went wrong'));}
      
    } catch (e) {
      log(e.toString());
      emit(SignInError(message: 'Something went wrong'));
    }
  }
}