import 'package:bloc/bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';

import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthService authService = getIt<AuthService>();
  SplashCubit() : super(SplashInitial());

  Future<void> checkServer() async {
    try {
      final bool madrasatiCheckServer = await authService.checkServer();
      if (madrasatiCheckServer == true) {
        emit(InternetConnected());
      } else {
        emit(InternetError());
      }
    } catch (e) {
      emit(SplashError());
    }
  }

  setLoadding() {
    emit(SplashLoading());
  }

  setInit() {
    emit(SplashInitial());
  }

  Future<void> loggedIn() async {
    bool? uid = await SecureStorageApi.instance.isUserLoggedIn();
    String? role = await SecureStorageApi.instance.getRole();
    try {
      if (uid == true) {
        if (role == 'student') {
          emit(StudentAlreadyLogin());
        } else if (role == 'school_manager') {
          emit(SchoolAlreadyLogin());
        } else if (role == 'guest') {
          await getIt<AuthService>().guestSignOut(
              token: await SecureStorageApi.instance.getRefreshToken() ?? "",
              guid: await SecureStorageApi.instance.getGuid() ?? "");
          emit(GuestAlreadyLogin());
        }
      } else {
        emit(UserLoggedOut());
      }
    } catch (e) {
      emit(SplashError());
    }
  }
}
