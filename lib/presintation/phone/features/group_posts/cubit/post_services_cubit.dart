import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrasati/data/models/comment_model/data.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/security/secure_storage_api.dart';
import 'package:madrasati/data/services/group_post_service.dart';
import 'package:madrasati/presintation/phone/features/group_posts/widgets/detailes_comment_section.dart';

part 'post_services_state.dart';

class PostServicesCubit extends Cubit<PostServicesState> {
  final GroupPostService _postService;
  int currentPage = 0;
  bool hasMore = true;
  bool isFetching = false;
  List<Widget> comments = [];
  ScrollController scrollController = ScrollController();
  PostServicesCubit(this._postService) : super(PostServicesInitial());

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

  Future<void> fetchComments(String postId) async {
    if (!hasMore || isFetching) return; // Stop fetching if no more pages or already fetching
    isFetching = true; // Set fetching flag to true to prevent multiple calls
    emit(PostServicesLoading());
    try {
      final response = await _postService.getAllComments(
          postId: postId,
          token: await SecureStorageApi.instance.getAccessToken() ?? "",
          page: currentPage,
          size: 10);
      log('Current page: $currentPage$response');
      if (response is CommentData) {
        currentPage++;
        hasMore = !response.last; // Update hasMore based on response
        // Convert the fetched data to PostCard widgets
        comments.addAll(response.content
            .map(
              (comment) => DetailesCommentSection(
                commentCreatedAt: comment.createdAt,
                commentText: comment.comment,
                commentAuthor: comment.author,
                commentId: comment.commentId,
              ),
            )
            .toList());
        emit(ComentLoaded(comments: comments, hasMore: hasMore));
      }
    } catch (e) {
      log(e.toString());
      emit(PostServicesError(message: e.toString()));
    }
  }
}
