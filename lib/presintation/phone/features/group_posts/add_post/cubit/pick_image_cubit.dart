import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());

  final ImagePicker _imagePicker = ImagePicker();
  final List<File> _selectedFiles = [];
  List<String> pathes=[];

  Future<void> pickImages() async {
    emit(PickImageLoading());
    try {
      final pickedFiles = await _imagePicker.pickMultiImage(
        maxWidth: 1080,
        maxHeight: 1920,
        imageQuality: 50,
      );
      if (pickedFiles.isNotEmpty) {
        _selectedFiles.clear();

        // Convert each picked image to a File and add to _selectedFiles for display
        _selectedFiles.addAll(pickedFiles.map((e) => File(e.path)));
        pathes=_selectedFiles.map((e) => e.path).toList();

        emit(PickImageSuccess(
            type: PickedFileType.image,
            selectedFiles: _selectedFiles,
            pathes: pathes));
      } else {
        emit(PickImageFailure(message: 'No images selected'));
      }
    } catch (e) {
      emit(PickImageFailure(message: e.toString()));
    }
  }



  void reset() {
    _selectedFiles.clear();
    emit(PickImageInitial());
  }
}

enum PickedFileType { image, file }
