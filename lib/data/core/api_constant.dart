class BaseUrl {
  static const String ipAddress = "http://10.0.2.2";

  static const String port = "7651";

  static String get baseUrl => '$ipAddress:$port';
}

class ApiConstants {
  static String baseUrl = BaseUrl.baseUrl;

  // API versions
  static const String authVersion = '/v1';
  static const String groupVersion = '/v1';
  static const String schoolVersion = '/v1';
}

class AuthEndpoints {
  static String baseUrl =
      '${ApiConstants.baseUrl}${ApiConstants.authVersion}/auth';

  static String userLogin = '$baseUrl/login';
  static String userLogout = '$baseUrl/logout';
  static String refreshToken = '$baseUrl/refreshToken';
  static String guestLogin = '$baseUrl/guestLogout';
  static String guestLogout = '$baseUrl/register';
}

class GroupeEndpoints {
  static String baseUrl =
      '${ApiConstants.baseUrl}${ApiConstants.groupVersion}/group';

  static String getAllPosts(int page, int size, String groupId) {
    return '$baseUrl/$groupId/post/getAllPosts?page=$page&size=$size';
  }

  static String createGroupPost(String groupId) {
    return '$baseUrl/$groupId/createPost';
  }

  static String deleteGroupPost(String groupId, String postId) {
    return '$baseUrl/$groupId/post/$postId/deletePost';
  }

  static String addComment(String postId, String comment) {
    return '$baseUrl/post/$postId/addComment';
  }

  static String deleteComment(String postId, String commentId) {
    return '$baseUrl/post/$postId/comment/$commentId/deleteComment';
  }

  static String addLike(String postId) {
    return '$baseUrl/post/$postId/addLike';
  }

  static String removeLike(String postId) {
    return '$baseUrl/post/$postId/removeLike';
  }
}

class SchoolEndpoints {
  static String baseUrl =
      '${ApiConstants.baseUrl}${ApiConstants.schoolVersion}/school';

  static String getAllSchools(int page, int size) {
    return '$baseUrl/getAllSchools?page=$page&size=$size';
  }

  static String getSchoolById(String schoolId) {
    return '$baseUrl/getSchoolById/$schoolId';
  }

  static String uploadCoverImage(String schoolId) {
    return '$baseUrl/$schoolId/uploadCoverImage';
  }

  //$schoolId/uploadSchoolImages
  static String uploadSchoolImages(String schoolId) {
    return '$baseUrl/$schoolId/uploadSchoolImages';
  }
}
