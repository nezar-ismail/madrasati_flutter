import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthService authService = getIt.get<AuthService>();
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await authService.logout(
        refreshToken: await SecureStorageApi.instance.getRefreshToken()??"",
      );
      await SecureStorageApi.instance.logout();
      getIt<UserProfileCubit>().clearUserInfo();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}
