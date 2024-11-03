
import 'package:dio/dio.dart';
import 'package:madrasati/data/errors/global_exception.dart';
import 'package:madrasati/data/errors/internal_exception.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/models/group_models/group_post_page.dart';
import 'package:madrasati/data/repo_apis/group_post_api.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

class GroupPostService {
  final GroupPostApi _groupPostApi;

  GroupPostService(this._groupPostApi);
  Future<ResponsModel> getAllPosts({
    required String groupId,
    required String token,
    required int page,
    required int size,
  }) async {
    try {
      Response response = await _groupPostApi.getAllPosts(
        groupId: groupId,
        token: token,
        page: page,
        size: size,
      );
      switch (response.statusCode) {
        case 200:
          final data = PostResponse.fromMap(response.data['data']);
          if (data.empty) {
            return EmptyResponse();
          }
          return data;
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("Failed to fetch posts");
      }
    } catch (e) {
      logError('error with getAllPosts $e');
      rethrow;
    }
  }

  // Future<ResponsModel> createGroupPost({
  //   required String groupId,
  //   List<MultipartFile>? images,
  //   String? caption,
  //   required String token,
  // }) async {
  //   try {
  //     Response response = await _groupPostApi.createGroupPost(
  //       groupId: groupId,
  //       image: images,
  //       caption: caption,
  //       token: token,
  //     );
  //     return _handleResponse(response);
  //   } catch (e) {
  //     throw InternalException("Failed to create post: ${e.toString()}");
  //   }
  // }

  // Future<ResponsModel> deletePost({
  //   required String groupId,
  //   required String postId,
  //   required String token,
  // }) async {
  //   try {
  //     Response response = await _groupPostApi.deletePost(
  //       groupId: groupId,
  //       postId: postId,
  //       token: token,
  //     );
  //     return _handleResponse(response);
  //   } catch (e) {
  //     throw InternalException("Failed to delete post: ${e.toString()}");
  //   }
  // }

  // Future<ResponsModel> addComment({
  //   required String postId,
  //   required String comment,
  //   required String token,
  // }) async {
  //   try {
  //     Response response = await _groupPostApi.addComment(
  //       postId: postId,
  //       comment: comment,
  //       token: token,
  //     );
  //     return _handleResponse(response);
  //   } catch (e) {
  //     throw InternalException("Failed to add comment: ${e.toString()}");
  //   }
  // }

  // Future<ResponsModel> deleteComment({
  //   required String postId,
  //   required String commentId,
  //   required String token,
  // }) async {
  //   try {
  //     Response response = await _groupPostApi.deleteComment(
  //       postId: postId,
  //       commentId: commentId,
  //       token: token,
  //     );
  //     return _handleResponse(response);
  //   } catch (e) {
  //     throw InternalException("Failed to delete comment: ${e.toString()}");
  //   }
  // }

  Future<ResponsModel> addLike({
    required String postId,
    required String token,
  }) async {
    try {
      Response response = await _groupPostApi.addLike(
        postId: postId,
        token: token,
      );
          switch (response.statusCode) {
        case 200:
          final data = PostResponse.fromMap(response.data['data']);
          if (data.empty) {
            return EmptyResponse();
          }
          return data;
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("Failed to fetch posts");
      }
    } catch (e) {
      throw InternalException("Failed to add like: ${e.toString()}");
    }
  }

  // Future<ResponsModel> removeLike({
  //   required String postId,
  //   required String token,
  // }) async {
  //   try {
  //     Response response = await _groupPostApi.removeLike(
  //       postId: postId,
  //       token: token,
  //     );
  //     return _handleResponse(response);
  //   } catch (e) {
  //     throw InternalException("Failed to remove like: ${e.toString()}");
  //   }
  // }
}
