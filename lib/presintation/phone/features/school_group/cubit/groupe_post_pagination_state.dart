part of 'groupe_post_pagination_cubit.dart';

sealed class GroupePostPaginationState extends Equatable {
  const GroupePostPaginationState();

  @override
  List<Object> get props => [];
}

final class GroupePostPaginationInitial extends GroupePostPaginationState {}

final class PostLoading extends GroupePostPaginationInitial {}

final class PostEmpty extends GroupePostPaginationInitial {}

final class PostLoaded extends GroupePostPaginationInitial {
  final List<Widget> posts; // Store widgets for displaying
  final bool last;

  PostLoaded({required this.posts, required this.last});

  @override
  List<Object> get props => [posts, last];
}

final class PostError extends GroupePostPaginationInitial {
  final String message;

  PostError(this.message);

  @override
  List<Object> get props => [message];
}