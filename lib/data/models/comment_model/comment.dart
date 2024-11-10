// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:madrasati/data/models/comment_model/data.dart';


class CommentsResult {
  final String timestamp;
  final int status;
  final bool success;
  final String message;
  final CommentData data;
  CommentsResult({
    required this.timestamp,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  /// Creates a copy of this [CommentsResult] but with the given fields
  /// replaced with the new values.
  ///
  /// If a field is not provided, it will keep its current value.
  ///
  /// This method is useful when you need to update a [CommentsResult] object
  /// without having to create a new instance.
  ///
  /// Example:
  ///
  /// 
  CommentsResult copyWith({
    String? timestamp,
    int? status,
    bool? success,
    String? message,
    CommentData? data,
  }) {
    return CommentsResult(
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  /// Converts this [CommentsResult] instance into a [Map] with keys 'timestamp',
  /// 'status', 'success', 'message', and 'data', and their respective values
  /// from the instance. This is useful for serializing the object to JSON or
  /// other formats that use key-value pairs.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'status': status,
      'success': success,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory CommentsResult.fromMap(Map<String, dynamic> map) {
    return CommentsResult(
      timestamp: map['timestamp'] as String,
      status: map['status'] as int,
      success: map['success'] as bool,
      message: map['message'] as String,
      data: CommentData.fromMap(map['data'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentsResult.fromJson(String source) => CommentsResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResponseResult(timestamp: $timestamp, status: $status, success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(covariant CommentsResult other) {
    if (identical(this, other)) return true;
  
    return 
      other.timestamp == timestamp &&
      other.status == status &&
      other.success == success &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode {
    return timestamp.hashCode ^
      status.hashCode ^
      success.hashCode ^
      message.hashCode ^
      data.hashCode;
  }
  }
