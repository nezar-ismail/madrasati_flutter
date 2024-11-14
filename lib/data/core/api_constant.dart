class BaseUrl {
  static const String ipAddress = "http://192.168.1.26";
  static const String port = "8080";
  static final String baseUrl = '$ipAddress:$port';  
}

class ApiConstants {
  static final String baseUrl = BaseUrl.baseUrl; 
  static final String baseUrlWithPort = '${BaseUrl.ipAddress}:${BaseUrl.port}';

  static const String authVersion = '/v1';
  static const String groupVersion = '/v1';
  static const String schoolVersion = '/v1';
}

class AuthEndpoints {
  static final String baseUrl = '${ApiConstants.baseUrl}${ApiConstants.authVersion}/auth';

  static final String schoolLogin = '$baseUrl/login';
  static final String studentLogin = '$baseUrl/login';


  static final String userLogout = '$baseUrl/logout';
  static final String refreshToken = '$baseUrl/refreshToken';
  static final String guestLogin = '$baseUrl/guestLogin';
  static final String guestLogout = '$baseUrl/guestLogout';

}
class UserEndpoints {
  static final String baseUrl =
      '${ApiConstants.baseUrl}${ApiConstants.authVersion}/user';

  static final String editPassword = '$baseUrl/changePassword';
}

class GroupeEndpoints {
  static final String baseUrl =
      '${ApiConstants.baseUrl}${ApiConstants.groupVersion}/group';

  static String getAllPosts(int page, int size, String groupId) {
    return '$baseUrl/$groupId/post/getAllPosts?page=$page&size=$size';
  }

  static String getAllComments(int page, int size, String postId) {
    return '$baseUrl/post/$postId/comments?page=$page&size=$size';
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
    return '$baseUrl/post/$postId/comment/$commentId';
  }

  static String addLike(String postId) {
    return '$baseUrl/post/$postId/addLike';
  }

  static String removeLike(String postId) {
    return '$baseUrl/post/$postId/removeLike';
  }
}

class SchoolEndpoints {
  static final String baseUrl =
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

  static String uploadSchoolImages(String schoolId) {
    return '$baseUrl/$schoolId/uploadSchoolImages';
  }

    static String getAllFeedbacks(int page, int size, String schoolId) {
    return '$baseUrl/$schoolId/getSchoolFeedBacks?page=$page&size=$size';
  }
}
