part of 'groupe_post_pagination_cubit.dart';

sealed class GroupePostPaginationState extends Equatable {
  const GroupePostPaginationState();

  @override
  List<Object> get props => [];
}

final class GroupePostPaginationInitial extends GroupePostPaginationState {}

final class PostLoading extends GroupePostPaginationInitial {}

final class PostLoaded extends GroupePostPaginationInitial {
  final List<Widget> posts; // Store widgets for displaying
  final bool hasMore;

  PostLoaded({required this.posts, required this.hasMore});

  @override
  List<Object> get props => [posts, hasMore];
}

final class PostError extends GroupePostPaginationInitial {
  final String message;

  PostError(this.message);

  @override
  List<Object> get props => [message];
}