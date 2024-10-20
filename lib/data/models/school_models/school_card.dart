import 'dart:convert';

import 'package:madrasati/data/models/common_response_model.dart';

class SchoolCard implements ResponsModel {
  final String id;
  final String schoolName;
  final String schoolCoverImage;
  final String schoolType;
  final double averageRating;
  SchoolCard({
    required this.id,
    required this.schoolName,
    required this.schoolCoverImage,
    required this.schoolType,
    required this.averageRating,
  });

  SchoolCard copyWith({
    String? id,
    String? schoolName,
    String? schoolCoverImage,
    String? schoolType,
    double? averageRating,
  }) {
    return SchoolCard(
      id: id ?? this.id,
      schoolName: schoolName ?? this.schoolName,
      schoolCoverImage: schoolCoverImage ?? this.schoolCoverImage,
      schoolType: schoolType ?? this.schoolType,
      averageRating: averageRating ?? this.averageRating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'schoolName': schoolName,
      'schoolCoverImage': schoolCoverImage,
      'schoolType': schoolType,
      'averageRating': averageRating,
    };
  }

  factory SchoolCard.fromMap(Map<String, dynamic> map) {
    return SchoolCard(
      id: map['id'] as String,
      schoolName: map['schoolName'] as String,
      schoolCoverImage: map['schoolCoverImage'] as String,
      schoolType: map['schoolType'] as String,
      averageRating: map['averageRating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolCard.fromJson(String source) =>
      SchoolCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SchoolCard(id: $id, schoolName: $schoolName, schoolCoverImage: $schoolCoverImage, schoolType: $schoolType, averageRating: $averageRating)';
  }

  @override
  bool operator ==(covariant SchoolCard other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.schoolName == schoolName &&
        other.schoolCoverImage == schoolCoverImage &&
        other.schoolType == schoolType &&
        other.averageRating == averageRating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        schoolName.hashCode ^
        schoolCoverImage.hashCode ^
        schoolType.hashCode ^
        averageRating.hashCode;
  }
}
