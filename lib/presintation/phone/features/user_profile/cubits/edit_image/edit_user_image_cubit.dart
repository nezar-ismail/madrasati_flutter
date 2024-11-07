import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_user_image_state.dart';

class UserImageCubit extends Cubit<EditUserImageState> {
  UserImageCubit() : super(EditUserImageInitial());

  final ImagePicker _imagePicker = ImagePicker();
  Future<void> pickImage({required ImageSource source}) async {
    try {
      final pickedImage = await _imagePicker.pickImage(source: source);
      if (pickedImage != null) {
        File file = File(pickedImage.path);
        // LocalUserModel.setUserImage(pickedImage.path);

        emit(UserImageLoaded(file));
      } else {
        emit(UserImageError("No image selected."));
      }
    } catch (e) {
      emit(UserImageError(e.toString()));
    }
  }

  Future<MultipartFile> getMultipartFile(File file) async {
    return MultipartFile.fromFileSync(file.path,
        filename: file.path.split(Platform.pathSeparator).last);
  }

  void set() {
    if (state is UserImageLoaded) {
      emit(EditUserImageInitial());
    }
  }

  Map<String, dynamic>? user;
  postPatientImage({required File file, required int userId}) async {
    try {
      if (state is UserImageLoaded) {
        MultipartFile imageFile = await getMultipartFile(file);
        // user =
        //     await PatientService(usersAPI: PatientAPI(), imageAPI: ImageAPI())
        //         .updateImage(file: imageFile, userId: userId);
        if (user?['message'] == 'Image uploaded successfully') {
          // await LocalUserModel.deleteUserImage();
          // await LocalUserModel.setUserImage(user?['image-url']);
          emit(UserImageUpdated());
        }
      }
    } catch (e) {
      emit(UserImageNotUpdated(e.toString()));
    }
  }

}
