// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comment {
  final String commentId;
  final String comment;
  final String author;
  final String createdAt;
  final String authorId;
  Comment({
    required this.authorId,
    required this.commentId,
    required this.comment,
    required this.author,
    required this.createdAt,
  });

  /// Creates a copy of this [Comment] with the given fields replaced with the
  /// new values.
  ///
  /// The fields that can be replaced are:
  ///
  /// * [commentId]
  /// * [comment]
  /// * [author]
  /// * [createdAt]
  ///
  /// If any of the fields are null, the corresponding field of this object
  /// is used instead.
  Comment copyWith({
    String? commentId,
    String? comment,
    String? author,
    String? createdAt,
    String? authorId
  }) {
    return Comment(
      authorId: authorId ?? this.authorId,
      commentId: commentId ?? this.commentId,
      comment: comment ?? this.comment,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt
    );
  }

  /// Converts the [Comment] object to a map.
  ///
  /// Returns a [Map<String, dynamic>] containing key-value pairs representing
  /// the properties of the [Comment] object.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'comment': comment,
      'author': author,
      'createdAt': createdAt,
      'authorId': authorId
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      authorId: map['authorId'] as String,
      commentId: map['commentId'] as String,
      comment: map['comment'] as String,
      author: map['author'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(commentId: $commentId, comment: $comment, author: $author, createdAt: $createdAt authorId: $authorId)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.commentId == commentId &&
      other.comment == comment &&
      other.author == author &&
      other.authorId == authorId &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
      comment.hashCode ^
      author.hashCode ^
      authorId.hashCode ^
      createdAt.hashCode;
  }
}
