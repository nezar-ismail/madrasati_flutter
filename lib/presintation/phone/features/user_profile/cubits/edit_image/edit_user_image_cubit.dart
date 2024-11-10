import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_user_image_state.dart';

class UserImageCubit extends Cubit<EditUserImageState> {
  UserImageCubit() : super(EditUserImageInitial());

  final ImagePicker _imagePicker = ImagePicker();
  /// Picks an image from the device's gallery or camera.
  ///
  /// [source] is either [ImageSource.camera] or [ImageSource.gallery].
  ///
  /// If an image is successfully picked, it emits [UserImageLoaded] with the picked image.
  /// If no image is selected, it emits [UserImageError] with an error message.
  /// If an error occurs while picking the image, it emits [UserImageError] with the error message.
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
    } on Exception catch (e) {
      emit(UserImageError(e.toString()));
    }
  }

  /// Converts a [File] into a [MultipartFile].
  ///
  /// [file] is the file to be converted.
  ///
  /// Returns a [MultipartFile] created from the given file.
  Future<MultipartFile> getMultipartFile(File file) async {
    // Create a MultipartFile from the file path
    return MultipartFile.fromFileSync(
      file.path,
      filename: file.path.split(Platform.pathSeparator).last,
    );
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
        //! MultipartFile imageFile = await getMultipartFile(file);
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
