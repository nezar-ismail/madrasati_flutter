// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Content {
  String authorId;
  String caption;
  String groupId;
  List<String> imagePost;
  List<String> commentPost;
  List<String> likePost;
  Content({
    required this.authorId,
    required this.caption,
    required this.groupId,
    required this.imagePost,
    required this.commentPost,
    required this.likePost,
  });

  Content copyWith({
    String? authorId,
    String? caption,
    String? groupId,
    List<String>? imagePost,
    List<String>? commentPost,
    List<String>? likePost,
  }) {
    return Content(
      authorId: authorId ?? this.authorId,
      caption: caption ?? this.caption,
      groupId: groupId ?? this.groupId,
      imagePost: imagePost ?? this.imagePost,
      commentPost: commentPost ?? this.commentPost,
      likePost: likePost ?? this.likePost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorId': authorId,
      'caption': caption,
      'groupId': groupId,
      'imagePost': imagePost,
      'commentPost': commentPost,
      'likePost': likePost,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      authorId: map['authorId'] as String,
      caption: map['caption'] as String,
      groupId: map['groupId'] as String,
      imagePost: List<String>.from(map['imagePost'].map((id) => id.toString())),
      commentPost:
          List<String>.from(map['commentPost'].map((id) => id.toString())),
      likePost: List<String>.from(map['likePost'].map((id) => id.toString())),
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Content(authorId: $authorId, caption: $caption, groupId: $groupId, imagePost: $imagePost, commentPost: $commentPost, likePost: $likePost)';
  }

  @override
  bool operator ==(covariant Content other) {
    if (identical(this, other)) return true;

    return other.authorId == authorId &&
        other.caption == caption &&
        other.groupId == groupId &&
        listEquals(other.imagePost, imagePost) &&
        listEquals(other.commentPost, commentPost) &&
        listEquals(other.likePost, likePost);
  }

  @override
  int get hashCode {
    return authorId.hashCode ^
        caption.hashCode ^
        groupId.hashCode ^
        imagePost.hashCode ^
        commentPost.hashCode ^
        likePost.hashCode;
  }
}
