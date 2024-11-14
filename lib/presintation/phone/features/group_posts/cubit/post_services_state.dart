part of 'post_services_cubit.dart';

sealed class PostServicesState extends Equatable {
  const PostServicesState();

  @override
  List<Object> get props => [];
}

final class PostServicesInitial extends PostServicesState {}

final class PostServicesLoading extends PostServicesState {}

final class PostCreated extends PostServicesState {}

final class LikeAdded extends PostServicesState {}

final class LikeRemoved extends PostServicesState {}

final class CommentAdded extends PostServicesState {}

final class CommentRemoved extends PostServicesState {}

final class ComentLoaded extends PostServicesState {
  final List<Comment> comments; 
  final bool hasMore;

  const ComentLoaded({required this.comments, required this.hasMore});

  @override
  List<Object> get props => [comments, hasMore];
}

final class CommentEmpty extends PostServicesState {}

final class PostServicesError extends PostServicesState {
  final String message;
  const PostServicesError({required this.message});
}

