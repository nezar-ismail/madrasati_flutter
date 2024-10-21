import 'package:dio/dio.dart';
import 'package:madrasati/data/core/api.dart';
import 'package:madrasati/data/core/api_constant.dart';

class GroupPostApi {
  final API _api;
  GroupPostApi(this._api);

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

  Future<Response> createGroupPost(
      {required String groupId,
      List<MultipartFile>? image,
      String? caption,
      required String token}) async {
    String url = GroupeEndpoints.createGroupPost(groupId);
    Map<String, String> authHeader = makeHeaders(token);
    FormData body = FormData.fromMap({
      'images': image,
      'caption': caption,
    });
    Response response = await _api.post(url, body: body, headers: authHeader);
    return response;
  }

  Future<Response> deletePost(
      {required String groupId,
      required String postId,
      required String token}) async {
    String url = GroupeEndpoints.deleteGroupPost(groupId, postId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.delete(url, headers: authHeader);
    return response;
  }

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

  Future<Response> deleteComment(
      {required String postId,
      required String commentId,
      required String token}) async {
    String url = GroupeEndpoints.deleteComment(postId, commentId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.delete(url, headers: authHeader);
    return response;
  }

  Future<Response> addLike(
      {required String postId, required String token}) async {
    String url = GroupeEndpoints.addLike(postId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.post(url, headers: authHeader);
    return response;
  }

  Future<Response> removeLike(
      {required String postId, required String token}) async {
    String url = GroupeEndpoints.removeLike(postId);
    Map<String, String> authHeader = makeHeaders(token);
    Response response = await _api.delete(url, headers: authHeader);
    return response;
  }

  Map<String, String> makeHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }
}
