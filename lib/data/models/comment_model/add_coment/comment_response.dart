import 'package:madrasati/data/models/comment_model/comment_data.dart';
import 'package:madrasati/data/models/common_response_model.dart';

class ResponseData {
  final String timestamp;
  final int status;
  final bool success;
  final String message;
  final CommentAddedData data;

  ResponseData({
    required this.timestamp,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      timestamp: json['timestamp'] as String,
      status: json['status'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: CommentAddedData.fromJson(json['data']),
    );
  }

  /// Converts the object to a JSON-serializable map.
  ///
  /// This is the inverse of [ResponseData.fromJson].
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'status': status,
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CommentAddedData implements ResponsModel{
  final String commentId;
  final String authorId;
  final String comment;
  final String postId;
  final String createdAt;

  CommentAddedData({
    required this.commentId,
    required this.authorId,
    required this.comment,
    required this.postId,
    required this.createdAt,
  });

  factory CommentAddedData.fromJson(Map<String, dynamic> json) {
    return CommentAddedData(
      commentId: json['commentId'] as String,
      authorId: json['authorId'] as String,
      comment: json['comment'] as String,
      postId: json['postId'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  /// Converts the [CommentAddedData] object to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing key-value pairs representing
  /// the properties of the [CommentAddedData] object.
  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'authorId': authorId,
      'comment': comment,
      'postId': postId,
      'createdAt': createdAt,
    };
  }

  /// Converts the [CommentAddedData] object to a [Comment] object.
  ///
  /// The [author] parameter is used to set the author of the comment.
  ///
  /// Returns a [Comment] object.
Comment toComment(String author) {
    return Comment(
      authorId: authorId,
      commentId: commentId,
      comment: comment,
      author: author ,
      createdAt: createdAt,
    );
  }
} 

