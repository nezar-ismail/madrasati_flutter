// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:madrasati/data/models/common_response_model.dart';

class SchoolCard implements ResponsModel {
  final String id;
  final String schoolName;
  final String schoolCoverImage;
  final String schoolType;
  final double? averageRating;
  SchoolCard({
    required this.id,
    required this.schoolName,
    required this.schoolCoverImage,
    required this.schoolType,
    this.averageRating,
  });

/// Creates a copy of this [SchoolCard] but with the given fields replaced with the
/// new values.
///
/// If a field is not provided, it will keep its current value.
///
/// This method is useful when you need to update a [SchoolCard] object without
/// having to create a new instance.
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

  /// Converts this [SchoolCard] object to a map.
  ///
  /// The map contains the following keys and values:
  ///
  /// * `'id'`: [id]
  /// * `'schoolName'`: [schoolName]
  /// * `'schoolCoverImage'`: [schoolCoverImage]
  /// * `'schoolType'`: [schoolType]
  /// * `'averageRating'`: [averageRating]
  ///
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
      averageRating: map['averageRating'] != null ? map['averageRating'] as double : 5.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolCard.fromJson(String source) => SchoolCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  /// Returns a string representation of this [SchoolCard] object.
  ///
  /// The string representation will include all the properties of the
  /// [SchoolCard] object, in the format:
  ///
  /// `SchoolCard(id: $id, schoolName: $schoolName, schoolCoverImage: $schoolCoverImage, schoolType: $schoolType, averageRating: $averageRating)`
  ///
  String toString() {
    return 'SchoolCard(id: $id, schoolName: $schoolName, schoolCoverImage: $schoolCoverImage, schoolType: $schoolType, averageRating: $averageRating)';
  }

  @override
  bool operator ==(covariant SchoolCard other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
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
