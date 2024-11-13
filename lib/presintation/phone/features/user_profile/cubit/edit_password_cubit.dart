import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/authentication_service.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

part 'edit_password_state.dart';

class EditPasswordCubit extends Cubit<EditPasswordState> {
  final AuthService _authService = getIt<AuthService>();
  EditPasswordCubit() : super(EditPasswordInitial());


  /// Edits the user's password.
  ///
  /// This function emits [EditPasswordLoading] while it is running,
  /// then emits either [EditPasswordSuccess] on success or
  /// [EditPasswordError] on failure.
  ///
  /// [oldPassword] is the user's current password.
  ///
  /// [newPassword] is the new password to set.
  Future<void> editPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(EditPasswordLoading());
    try {
      ResponsModel responsModel = await _authService.editPassword(oldPassword: oldPassword, newPassword: newPassword, token: await SecureStorageApi.instance.getAccessToken()??"" );
      if(responsModel is EmptyResponse){
        emit(EditPasswordSuccess());
      }else{
        emit(EditPasswordError(message: 'Something went wrong'));}
      
    } catch (e) {
      logError(e.toString());
      emit(EditPasswordError(message: 'Something went wrong'));
    }
  }
}
