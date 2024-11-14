import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/core/get_it.dart';
import 'package:madrasati/data/models/comment_model/add_coment/comment_response.dart';
import 'package:madrasati/data/models/comment_model/comment_data.dart';
import 'package:madrasati/data/models/comment_model/data.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/group_post_service.dart';
import 'package:madrasati/presintation/phone/features/student/cubit/student_home_cubit.dart';

part 'post_services_state.dart';

class PostServicesCubit extends Cubit<PostServicesState> {
  final GroupPostService _postService = getIt<GroupPostService>();
  int currentPage = 0;
  String commentCount = '0';
  bool hasMore = true;
  bool isFetching = false;
  List<Comment> comments = [];
  ScrollController scrollController = ScrollController();
  PostServicesCubit() : super(PostServicesInitial());

  /// Sends a request to like a post.
  ///
  /// The post is liked on the server and a [LikeAdded] event is emitted.
  /// If there is an error a [PostServicesError] event is emitted.
  ///
  Future<void> likePost(String postId) async {
    emit(PostServicesLoading());
    try {
      final response = await _postService.addLike(
          postId: postId,
          token: await SecureStorageApi.instance.getAccessToken() ?? "");
      if (response is EmptyResponse) {
        emit(LikeAdded());
      } else {
        emit(PostServicesError(message: response.toString()));
      }
    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }

  /// Sends a request to unlike a post.
  ///
  /// The post is unliked on the server and a [LikeRemoved] event is emitted.
  /// If there is an error a [PostServicesError] event is emitted.
  ///
  Future<void> unlikePost(String postId) async {
    emit(PostServicesLoading());
    try {
      final response = await _postService.removeLike(
          postId: postId,
          token: await SecureStorageApi.instance.getAccessToken() ?? "");
      if (response is EmptyResponse) {
        emit(LikeRemoved());
      } else {
        emit(PostServicesError(message: response.toString()));
      }
    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }

  /// Fetches comments for a given post.
  ///
  /// If there are more comments to fetch, the [hasMore] flag is set to true.
  /// If the fetching is successfull, the state is updated with the fetched
  /// comments and [hasMore] flag. If the fetching fails, the state is updated
  /// with the error message.
  ///
  /// This method is idempotent, meaning it can be safely called multiple times,
  /// and it will only fetch new comments if there are more comments to fetch.
  ///
  /// [postId] is the id of the post to fetch comments from.
  Future<void> fetchComments(String postId) async {
    if (!hasMore || isFetching)return; // Stop fetching if no more pages or already fetching
    isFetching = true; // Set fetching flag to true to prevent multiple calls
    emit(PostServicesLoading());
    try {
      final response = await _postService.getAllComments(
          postId: postId,
          token: await SecureStorageApi.instance.getAccessToken() ?? "",
          page: currentPage,
          size: 10);
      if (response is CommentData) {
        currentPage++;
        hasMore = !response.last;
        comments.addAll(response.content);
        isFetching = false;
        emit(ComentLoaded(
            comments: comments,
            hasMore: hasMore)); // Emit state with the updated list
      }else if (response is EmptyResponse){
        isFetching = false;
        emit(CommentEmpty());
      }

    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }

  /// Sends a request to add a comment to a post.
  ///
  /// The comment is added on the server and a [CommentAdded] event is emitted.
  /// If there is an error a [PostServicesError] event is emitted.
  ///
  /// This method is idempotent, meaning it can be safely called multiple times,
  /// and it will only add the comment once.
  ///
  /// [postId] is the id of the post to add a comment to.
  /// [comment] is the comment to add.
  Future<void> addComment(String postId, String comment) async {
    emit(PostServicesLoading());
    try {
      // Access the current user info from the UserProfileCubit
      final localStudent = getIt<UserProfileCubit>().state;

      if (localStudent == null) {
        emit(PostServicesError(message: 'No user found'));
        return;
      }

      final response = await _postService.addComment(
        postId: postId,
        token: await SecureStorageApi.instance.getAccessToken() ?? "",
        comment: comment,
      );
      if (response is CommentAddedData) {
        String author = '${localStudent.firstName!} ${localStudent.lastName!}';
        log(author);
        // Directly add the new comment to the list of comments
        comments.insert(0, response.toComment(author));
        commentCount = (int.parse(commentCount) + 1).toString();
        emit(CommentAdded());
        emit(ComentLoaded(
            comments: comments,
            hasMore: hasMore)); // Emit updated comments list
      } else {
        emit(PostServicesError(message: response.toString()));
      }
    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }

  /// Deletes a comment from a post.
  ///
  /// This method is idempotent, meaning it can be safely called multiple times,
  /// and it will only remove the comment once.
  ///
  /// [postId] is the id of the post to delete the comment from.
  /// [commentId] is the id of the comment to delete.
  ///
  /// If the deletion is successful, the state is updated with the comment removed
  /// from the list of comments and the comment count is decremented.
  /// If the deletion fails, the state is updated with an error message.
  Future<void> deleteComment(String postId, String commentId) async {
    emit(PostServicesLoading());
    try {
      // Access the current user info from the UserProfileCubit
      final localStudent = getIt<UserProfileCubit>().state;

      if (localStudent == null) {
        emit(PostServicesError(message: 'No user found'));
        return;
      }

      final response = await _postService.deleteComment(
        postId: postId,
        token: await SecureStorageApi.instance.getAccessToken() ?? "",
        commentId: commentId,
      );
      if (response is EmptyResponse) {
        // Directly remove the comment from the list of comments
        comments.removeWhere((comment) => comment.commentId == commentId);
        commentCount = (int.parse(commentCount) - 1).toString();
        emit(CommentRemoved());
        emit(ComentLoaded(
            comments: comments,
            hasMore: hasMore)); // Emit updated comments list
      } else {
        emit(PostServicesError(message: response.toString()));
      }
    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }

  Future<void> createPost(
      String groupId, List<String> pathes, String content) async {
    emit(PostServicesLoading());
    try {
      final response = await _postService.createGroupPost(
        groupId: groupId,
        token: await SecureStorageApi.instance.getAccessToken() ?? "",
        caption: content,
        pathes: pathes,
      );
      if (response is EmptyResponse) {
        emit(PostCreated());
      } else {
        emit(PostServicesError(message: response.toString()));
      }
    } catch (e) {
      emit(PostServicesError(message: e.toString()));
    }
  }
}
