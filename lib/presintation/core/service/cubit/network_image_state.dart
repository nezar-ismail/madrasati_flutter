part of 'network_image_cubit.dart';

sealed class NetworkImageState extends Equatable {
  const NetworkImageState();

  @override
  List<Object?> get props => [];
}

final class NetworkImageInitial extends NetworkImageState {}


final class ImageLoading extends NetworkImageState {}

final class ImageLoaded extends NetworkImageState{
  final Uint8List imageData;

  const ImageLoaded(this.imageData);

  @override
  List<Object?> get props => [imageData];
}

final class ImageError extends NetworkImageState {
  final String message;

  const ImageError(this.message);

  @override
  List<Object?> get props => [message];
}