// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:madrasati/data/models/common_response_model.dart';

class FeedbackContent implements ResponsModel {
  final String userFirstName;
  final String createdAt;
  final String userId;
  final String feedbackDescription;
  final String feedbackId;

  FeedbackContent({
    required this.userFirstName,
    required this.createdAt,
    required this.userId,
    required this.feedbackDescription,
    required this.feedbackId,
  });

  /// Creates a copy of this [FeedbackContent] but with the given fields replaced with the new values.
  ///
  /// If a field is not provided, it will keep its current value from the existing [FeedbackContent] instance.
  ///
  /// This method is useful when you need to update a [FeedbackContent] object without having to create a new instance.
  FeedbackContent copyWith({
    String? userFirstName,
    String? createdAt,
    String? userId,
    String? feedbackDescription,
    String? feedbackId,
  }) {
    return FeedbackContent(
      userFirstName: userFirstName ?? this.userFirstName,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      feedbackDescription: feedbackDescription ?? this.feedbackDescription,
      feedbackId: feedbackId ?? this.feedbackId,
    );
  }

  /// Converts the [FeedbackContent] object to a map.
  ///
  /// Returns a [Map<String, dynamic>] containing key-value pairs representing
  /// the properties of the [FeedbackContent] object.
  ///
  /// The returned map has the following structure:
  ///
  /// - userFirstName: The user's first name.
  /// - createdAt: The creation date of the feedback as a Unix timestamp (milliseconds since epoch).
  /// - userId: The user's ID.
  /// - feedbackDescription: The description of the feedback.
  /// - feedbackId: The ID of the feedback.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userFirstName': userFirstName,
      'createdAt': createdAt,
      'userId': userId,
      'feedbackDescription': feedbackDescription,
      'feedbackId': feedbackId,
    };
  }

  factory FeedbackContent.fromMap(Map<String, dynamic> map) {
    return FeedbackContent(
      userFirstName: map['userFirstName'] as String,
      createdAt: map['createdAt'] as String,
      userId: map['userId'] as String,
      feedbackDescription: map['feedbackDescription'] as String,
      feedbackId: map['feedbackId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackContent.fromJson(String source) => FeedbackContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  /// Returns a string representation of the [FeedbackContent] object, including
  /// all its fields such as userFirstName, createdAt, userId, feedbackDescription,
  /// and feedbackId.
  String toString() {
    return 'FeedbackContent(userFirstName: $userFirstName, createdAt: $createdAt, userId: $userId, feedbackDescription: $feedbackDescription, feedbackId: $feedbackId)';
  }

  @override
  bool operator ==(covariant FeedbackContent other) {
    if (identical(this, other)) return true;
  
    return 
      other.userFirstName == userFirstName &&
      other.createdAt == createdAt &&
      other.userId == userId &&
      other.feedbackDescription == feedbackDescription &&
      other.feedbackId == feedbackId;
  }

  @override
  int get hashCode {
    return userFirstName.hashCode ^
      createdAt.hashCode ^
      userId.hashCode ^
      feedbackDescription.hashCode ^
      feedbackId.hashCode;
  }
}
