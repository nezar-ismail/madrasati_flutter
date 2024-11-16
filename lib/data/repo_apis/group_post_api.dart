import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/api_constant.dart';

import '../utils/content_type_convert.dart';

class GroupPostApi {
  final API _api;
  GroupPostApi(this._api);

  /// Fetches all posts for a specified group.
  ///
  /// [groupId] is the identifier for the group whose posts are to be fetched.
  /// [token] is the authentication token required for the API request.
  /// [page] is the page number for pagination.
  /// [size] indicates the number of posts to fetch per page.
  ///
  /// Returns a [Future] containing the server [Response] with the posts data if the request is successful.
  /// Throws an exception if the request fails.
  Future<Response> getAllPosts(
      {required String groupId,
      required String token,
      required int page,
      required int size}) async {
    String url = GroupeEndpoints.getAllPosts(page, size, groupId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.get(url, headers: authHeader);
    return response;
  }

  /// Fetches all comments for a specified post.
  ///
  /// [postId] is the identifier for the post whose comments are to be fetched.
  /// [token] is the authentication token required for the API request.
  /// [page] is the page number for pagination.
  /// [size] indicates the number of comments to fetch per page.
  ///
  /// Returns a [Future] containing the server [Response] with the comments data if the request is successful.
  /// Throws an exception if the request fails.
  Future<Response> getAllComments(
      {required String postId,
      required String token,
      required int page,
      required int size}) async {
    String url = GroupeEndpoints.getAllComments(page, size, postId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.get(url, headers: authHeader);
    return response;
  }

  /// Creates a new group post.
  ///
  /// [groupId] is the identifier for the group where the post will be created.
  /// [image] is an optional list of images to be attached to the post.
  /// [caption] is an optional description or title for the post.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the post creation data if successful.
  /// Throws an exception if the request fails.
  Future<Response> createGroupPost(
      {required String groupId,
      List<String>? pathes,
      String? caption,
      required String token}) async {
    String url = GroupeEndpoints.createGroupPost(groupId);
    Map<String, String> authHeader = makeHeaders(token);

    List<MultipartFile> imageFiles = [];
    if (pathes != null) {
      for (String path in pathes) {
        String fileType = ContentTypeConvert.getFileType(path);
        imageFiles.add(await MultipartFile.fromFile(
          path,
          filename: path.split('/').last,
          contentType: MediaType.parse(fileType),
        ));
      }
    }
    FormData body =
        FormData.fromMap({'caption': caption, 'images': imageFiles});

    Response response = await _api.post(url, body: body, headers: authHeader);
    return response;
  }

  /// Deletes a specific post within a group.
  ///
  /// [groupId] is the identifier for the group containing the post.
  /// [postId] is the identifier for the post to be deleted.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] indicating the result of the delete operation.
  /// Throws an exception if the request fails.
  Future<Response> deletePost(
      {required String groupId,
      required String postId,
      required String token}) async {
    String url = GroupeEndpoints.deleteGroupPost(groupId, postId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.delete(url, headers: authHeader);
    return response;
  }

  /// Adds a comment to a post in a group.
  ///
  /// [postId] is the identifier for the post to which the comment is to be added.
  /// [comment] is the text of the comment.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] with the comment creation data if successful.
  /// Throws an exception if the request fails.
  Future<Response> addComment(
      {required String postId,
      required String comment,
      required String token}) async {
    String url = GroupeEndpoints.addComment(postId, comment);
    Map<String, String> authHeader = makeHeaders(token);
    Map<String, String> body = {"comment": comment};
    Response response = await _api.post(url, body: body, headers: authHeader);
    return response;
  }

  /// Deletes a specific comment from a post in a group.
  ///
  /// [postId] is the identifier for the post from which the comment is to be deleted.
  /// [commentId] is the identifier for the comment to be deleted.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] indicating the result of the delete operation.
  /// Throws an exception if the request fails.
  Future<Response> deleteComment(
      {required String postId,
      required String commentId,
      required String token}) async {
    String url = GroupeEndpoints.deleteComment(postId, commentId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.delete(url, headers: authHeader);
    return response;
  }

  /// Adds a like to a specified post in a group.
  ///
  /// [postId] is the identifier for the post to which the like is to be added.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] indicating the result of the like operation.
  /// Throws an exception if the request fails.
  Future<Response> likeToggle(
      {required String postId, required String token}) async {
    String url = GroupeEndpoints.addLike(postId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.post(url, headers: authHeader);
    return response;
  }

  /// Removes a like from a specified post in a group.
  ///
  /// [postId] is the identifier for the post from which the like is to be removed.
  /// [token] is the authentication token required for the API request.
  ///
  /// Returns a [Future] containing the server [Response] indicating the result of the unlike operation.
  /// Throws an exception if the request fails.
  Future<Response> removeLike(
      {required String postId, required String token}) async {
    String url = GroupeEndpoints.removeLike(postId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.delete(url, headers: authHeader);
    return response;
  }

  /// Constructs and returns a map of headers for API requests.
  ///
  /// The headers include an 'Authorization' header containing the provided
  /// [token] in Bearer token format.
  ///
  /// [token]: The authentication token required for the API request.
  ///
  /// Returns a [Map<String, String>] containing the headers for the request.
  Map<String, String> makeHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }
}
