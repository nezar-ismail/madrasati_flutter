// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:madrasati/data/models/common_response_model.dart';

class LikeToggle implements ResponsModel {
  final bool isLiked;
  final String postId;
  final int likeCount;
  final String authId;
  LikeToggle({
    required this.isLiked,
    required this.postId,
    required this.likeCount,
    required this.authId,
  });


  LikeToggle copyWith({
    bool? isLiked,
    String? postId,
    int? likeCount,
    String? authId,
  }) {
    return LikeToggle(
      isLiked: isLiked ?? this.isLiked,
      postId: postId ?? this.postId,
      likeCount: likeCount ?? this.likeCount,
      authId: authId ?? this.authId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'liked': isLiked,
      'postId': postId,
      'likeCount': likeCount,
      'authorId': authId,
    };
  }

  factory LikeToggle.fromMap(Map<String, dynamic> map) {
    return LikeToggle(
      isLiked: map['liked'] as bool,
      postId: map['postId'] as String,
      likeCount: map['likeCount'] as int,
      authId: map['authorId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeToggle.fromJson(String source) => LikeToggle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LikeToggke(liked: $isLiked, postId: $postId, likeCount: $likeCount, authorId: $authId)';
  }

  @override
  bool operator ==(covariant LikeToggle other) {
    if (identical(this, other)) return true;
  
    return 
      other.isLiked == isLiked &&
      other.postId == postId &&
      other.likeCount == likeCount &&
      other.authId == authId;
  }

  @override
  int get hashCode {
    return isLiked.hashCode ^
      postId.hashCode ^
      likeCount.hashCode ^
      authId.hashCode;
  }
}

class Liked extends LikeToggle {
  Liked({
    required super.isLiked,
    required super.postId,
    required super.likeCount,
    required super.authId,
  });
}

class Unlike extends LikeToggle {
  Unlike({
    required super.isLiked,
    required super.postId,
    required super.likeCount,
    required super.authId,
  });
}
