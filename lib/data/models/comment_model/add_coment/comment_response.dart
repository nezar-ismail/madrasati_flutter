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

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'authorId': authorId,
      'comment': comment,
      'postId': postId,
      'createdAt': createdAt,
    };
  }

Comment toComment(String author) {
    return Comment(
      commentId: commentId,
      comment: comment,
      author: author ,
      createdAt: createdAt,
    );
  }
} 

