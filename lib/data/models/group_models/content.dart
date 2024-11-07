// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Content {
  String schoolName;
  String authorId;
  String caption;
  String groupId;
  String postId;
  String schoolImagePath;
  String postCreatedAt;
  int numberOfComment;
  int numberOfLike;
  bool isLiked;
  bool withImage;
  List<dynamic> imagePost;
  Content({
    required this.schoolName,
    required this.authorId,
    required this.caption,
    required this.groupId,
    required this.postId,
    required this.schoolImagePath,
    required this.postCreatedAt,
    required this.numberOfComment,
    required this.numberOfLike,
    required this.isLiked,
    required this.withImage,
    required this.imagePost,
  });

  Content copyWith({
    String? schoolName,
    String? authorId,
    String? caption,
    String? groupId,
    String? postId,
    String? schoolImagePath,
    String? postCreatedAt,
    int? numberOfComment,
    int? numberOfLike,
    bool? isLiked,
    bool? withImage,
    List<dynamic>? imagePost,
  }) {
    return Content(
      schoolName: schoolName ?? this.schoolName,
      authorId: authorId ?? this.authorId,
      caption: caption ?? this.caption,
      groupId: groupId ?? this.groupId,
      postId: postId ?? this.postId,
      schoolImagePath: schoolImagePath ?? this.schoolImagePath,
      postCreatedAt: postCreatedAt ?? this.postCreatedAt,
      numberOfComment: numberOfComment ?? this.numberOfComment,
      numberOfLike: numberOfLike ?? this.numberOfLike,
      isLiked: isLiked ?? this.isLiked,
      withImage: withImage ?? this.withImage,
      imagePost: imagePost ?? this.imagePost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'schoolName': schoolName,
      'authorId': authorId,
      'caption': caption,
      'groupId': groupId,
      'postId': postId,
      'schoolImagePath': schoolImagePath,
      'postCreatedAt': postCreatedAt,
      'numberOfComment': numberOfComment,
      'numberOfLike': numberOfLike,
      'isLiked': isLiked,
      'withImage': withImage,
      'imagePost': imagePost,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      schoolName: map['schoolName'] as String,
      authorId: map['authorId'] as String,
      caption: map['caption'] as String,
      groupId: map['groupId'] as String,
      postId: map['postId'] as String,
      schoolImagePath: map['schoolImagePath'] as String,
      postCreatedAt: map['createdAt'] as String,
      numberOfComment: map['commentCount'] as int,
      numberOfLike: map['likeCount'] as int,
      isLiked: map['userLiked'] as bool,
      withImage: map['withImage'] as bool,
      imagePost: List<dynamic>.from((map['imagePost'] as List<dynamic>),
    )
    );
  }


  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) => Content.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Content(schoolName: $schoolName, authorId: $authorId, caption: $caption, groupId: $groupId, postId: $postId, schoolImagePath: $schoolImagePath, postCreatedAt: $postCreatedAt, numberOfComment: $numberOfComment, numberOfLike: $numberOfLike, isLiked: $isLiked, withImage: $withImage, imagePost: $imagePost)';
  }

  @override
  bool operator ==(covariant Content other) {
    if (identical(this, other)) return true;
  
    return 
      other.schoolName == schoolName &&
      other.authorId == authorId &&
      other.caption == caption &&
      other.groupId == groupId &&
      other.postId == postId &&
      other.schoolImagePath == schoolImagePath &&
      other.postCreatedAt == postCreatedAt &&
      other.numberOfComment == numberOfComment &&
      other.numberOfLike == numberOfLike &&
      other.isLiked == isLiked &&
      other.withImage == withImage &&
      listEquals(other.imagePost, imagePost);
  }

  @override
  int get hashCode {
    return schoolName.hashCode ^
      authorId.hashCode ^
      caption.hashCode ^
      groupId.hashCode ^
      postId.hashCode ^
      schoolImagePath.hashCode ^
      postCreatedAt.hashCode ^
      numberOfComment.hashCode ^
      numberOfLike.hashCode ^
      isLiked.hashCode ^
      withImage.hashCode ^
      imagePost.hashCode;
  }
}
