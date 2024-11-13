
part of 'pick_image_cubit.dart';

abstract class PickImageState {}

class PickImageInitial extends PickImageState {}

class PickImageLoading extends PickImageState {}

class PickImageSuccess extends PickImageState {

  final List<File?> selectedFiles;
  final PickedFileType type;
  final List<String> pathes;

  PickImageSuccess({ required this.pathes, required this.selectedFiles,required this.type});
}

class PickImageFailure extends PickImageState {
  final String message;
  PickImageFailure({required this.message});
}