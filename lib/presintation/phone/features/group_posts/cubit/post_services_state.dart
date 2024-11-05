part of 'post_services_cubit.dart';

sealed class PostServicesState extends Equatable {
  const PostServicesState();

  @override
  List<Object> get props => [];
}

final class PostServicesInitial extends PostServicesState {}

final class PostServicesLoading extends PostServicesState {}

final class LikeAdded extends PostServicesState {}

final class LikeRemoved extends PostServicesState {}

final class PostServicesError extends PostServicesState {
  final String message;
  const PostServicesError({required this.message});
}

