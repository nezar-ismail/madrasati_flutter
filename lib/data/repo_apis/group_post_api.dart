import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';

class GroupApi {
  final API api;

  GroupApi(this.api);

  Future<Response> getAllPosts(
      {required String groupId,
      required String token,
      required int page,
      required int size}) async {
    String url =
        makeGroupUrl('$groupId/post/getAllPosts?page=$page&size=$size');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.get(url, headers: authHeader);
    return response;
  }

  Future<Response> createGroupPost(
      {required String groupId,
      List<MultipartFile>? image,
      String? caption,
      required String token}) async {
    String url = makeGroupUrl('$groupId/createPost');

    Map<String, String> authHeader = makeHeaders(token);

    FormData body = FormData.fromMap({
      'images': image,
      'caption': caption,
    });

    Response response = await api.post(url, body: body, headers: authHeader);
    return response;
  }

  Future<Response> deletePost(
      {required String groupId,
      required String postId,
      required String token}) async {
    String url = makeGroupUrl('$groupId/post/$postId/deletePost');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.delete(url, headers: authHeader);
    return response;
  }

  Future<Response> addComment(
      {required String postId,
      required String comment,
      required String token}) async {
    String url = makeGroupUrl('post/$postId/addComment');

    Map<String, String> authHeader = makeHeaders(token);

    Map<String, String> body = {"comment": comment};
    Response response = await api.post(url, body: body, headers: authHeader);
    return response;
  }

  Future<Response> deleteComment(
      {required String postId,
      required String commentId,
      required String token}) async {
    String url = makeGroupUrl('post/$postId/comment/$commentId');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.delete(url, headers: authHeader);
    return response;
  }

  Future<Response> addLike(
      {required String postId, required String token}) async {
    String url = makeGroupUrl('post/$postId/addLike');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.post(url, headers: authHeader);
    return response;
  }

  Future<Response> removeLike(
      {required String postId, required String token}) async {
    String url = makeGroupUrl('post/$postId/removeLike');
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await api.delete(url, headers: authHeader);
    return response;
  }

  Map<String, String> makeHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }

  String makeGroupUrl(String endPoint) {
    return 'v1/group/$endPoint';
  }
}
