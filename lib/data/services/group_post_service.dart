import 'package:dio/dio.dart';
import 'package:madrasati/data/errors/global_exception.dart';
import 'package:madrasati/data/errors/internal_exception.dart';
import 'package:madrasati/data/models/comment_model/add_coment/comment_response.dart';
import 'package:madrasati/data/models/comment_model/data.dart';
import 'package:madrasati/data/models/common_response_model.dart';
import 'package:madrasati/data/models/group_models/group_post_page.dart';
import 'package:madrasati/data/models/like/like_toggle.dart';
import 'package:madrasati/data/repo_apis/group_post_api.dart';
import 'package:madrasati/data/utils/custom_logs.dart';

class GroupPostService {
  final GroupPostApi _groupPostApi;

  GroupPostService(this._groupPostApi);

  /// Fetches all posts for a specified group.
  ///
  /// [groupId] is the identifier for the group whose posts are to be fetched.
  /// [token] is the authentication token required for the API request.
  /// [page] is the page number for pagination.
  /// [size] indicates the number of posts to fetch per page.
  ///
  /// Returns a [Future] containing the server [Response] with the posts data if the request is successful.
  /// Throws an exception if the request fails.
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

  /// Fetches all comments for a specified post.
  ///
  /// [postId] is the identifier for the post whose comments are to be fetched.
  /// [token] is the authentication token required for the API request.
  /// [page] is the page number for pagination.
  /// [size] indicates the number of comments to fetch per page.
  ///
  /// Returns a [Future] containing a [ResponsModel] which will be an instance
  /// of [CommentData] if the comments are successfully fetched.
  /// Throws a [GlobalException] if the server returns an error response,
  /// and an [InternalException] if there is any error during the fetching process.
  Future<ResponsModel> getAllComments({
    required String postId,
    required String token,
    required int page,
    required int size,
  }) async {
    try {
      Response response = await _groupPostApi.getAllComments(
        postId: postId,
        token: token,
        page: page,
        size: size,
      );
      switch (response.statusCode) {
        case 200:
          final data = CommentData.fromMap(response.data['data']);
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

  /// Creates a new group post.
  ///
  /// [groupId] is the identifier for the group where the post will be created.
  /// [images] is an optional list of images to be attached to the post.
  /// [caption] is an optional description or title for the post.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the post creation data if successful.
  /// Throws an exception if the request fails.
  Future<ResponsModel> createGroupPost({
    required String groupId,
    List<String>? pathes,
    String? caption,
    required String token,
  }) async {
    try {
      Response response = await _groupPostApi.createGroupPost(
        groupId: groupId,
        pathes: pathes,
        caption: caption,
        token: token,
      );
      switch (response.statusCode) {
        case 201:
          return EmptyResponse();

        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("Failed to fetch posts");
      }
    } catch (e) {
      throw InternalException("Failed to create post: ${e.toString()}");
    }
  }

  //? not in use
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

  /// Adds a comment to a post in a group.
  ///
  /// [postId] is the identifier for the post to which the comment is to be added.
  /// [comment] is the text of the comment to be added.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing a [ResponsModel] which will be an instance
  /// of [CommentAddedData] if the comment is successfully added.
  /// Throws a [GlobalException] if the server returns an error response,
  /// and an [InternalException] if there is any error during the add comment process.
  Future<ResponsModel> addComment({
    required String postId,
    required String comment,
    required String token,
  }) async {
    try {
      Response response = await _groupPostApi.addComment(
        postId: postId,
        comment: comment,
        token: token,
      );
      switch (response.statusCode) {
        case 201:
          final data = CommentAddedData.fromJson(response.data['data']);
          return data;
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("Failed to fetch posts");
      }
    } catch (e) {
      throw InternalException("Failed to add comment: ${e.toString()}");
    }
  }

  /// Deletes a comment from a post in a group.
  ///
  /// [postId] is the identifier for the post to delete the comment from.
  /// [commentId] is the identifier for the comment to delete.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] indicating the result of the delete operation.
  /// Throws an exception if the request fails.
  Future<ResponsModel> deleteComment({
    required String postId,
    required String commentId,
    required String token,
  }) async {
    try {
      Response response = await _groupPostApi.deleteComment(
        postId: postId,
        commentId: commentId,
        token: token,
      );
      switch (response.statusCode) {
        case 204:
          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("Failed to fetch posts");
      }
    } catch (e) {
      throw InternalException("Failed to delete comment: ${e.toString()}");
    }
  }

  /// Adds a like to a post in a group.
  ///
  /// [postId] is the identifier for the post to which the like is to be added.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] indicating the result of the like operation.
  /// Throws an exception if the request fails.
  Future<ResponsModel> likeToggle({
    required String postId,
    required String token,
  }) async {
    try {
      Response response = await _groupPostApi.likeToggle(
        postId: postId,
        token: token,
      );
      switch (response.statusCode) {
        case 200:
        final data = LikeToggle.fromMap(response.data['data']);
          if (data.isLiked) {
            return Liked(isLiked: data.isLiked, postId: data.postId, likeCount: data.likeCount, authId: data.authId);
          }
          return Unlike(isLiked: data.isLiked, postId: data.postId, likeCount: data.likeCount, authId: data.authId);
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

  /// Removes a like from a post in a group.
  ///
  /// [postId] is the identifier for the post to which the like is to be removed.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] indicating the result of the unlike operation.
  /// Throws an exception if the request fails.
  Future<ResponsModel> removeLike({
    required String postId,
    required String token,
  }) async {
    try {
      Response response = await _groupPostApi.removeLike(
        postId: postId,
        token: token,
      );
      switch (response.statusCode) {
        case 204:
          return EmptyResponse();
        default:
          if (response.data is Map<String, dynamic>) {
            throw GlobalException.fromResponse(response);
          }
          throw InternalException("Failed to fetch posts");
      }
    } catch (e) {
      throw InternalException("Failed to remove like: ${e.toString()}");
    }
  }
}
