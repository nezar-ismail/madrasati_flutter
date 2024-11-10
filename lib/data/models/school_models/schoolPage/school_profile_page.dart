// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:madrasati/data/models/common_response_model.dart';

import 'school_teacher.dart';

class SchoolProfilepage implements ResponsModel {
  String schoolId;
  String schoolName;
  String schoolCoverImage;
  String schoolDescription;
  String schoolPhoneNumber;
  int schoolStudentCount;
  String schoolLocation;
  Map<String, dynamic> averageRating;
  String schoolEmail;
  List<String> schoolFeedBacks;
  List<String> schoolImages;
  List<Teacher> teachers;
  SchoolProfilepage({
    required this.schoolId,
    required this.schoolName,
    required this.schoolCoverImage,
    required this.schoolDescription,
    required this.schoolPhoneNumber,
    required this.schoolStudentCount,
    required this.schoolLocation,
    required this.averageRating,
    required this.schoolEmail,
    required this.schoolFeedBacks,
    required this.schoolImages,
    required this.teachers,
  });

  /// Creates a copy of this [SchoolProfilepage] but with the given fields replaced with the new values.
  ///
  /// If a field is not provided, it will keep its current value.
  ///
  /// This method is useful when you need to update a [SchoolProfilepage] object without
  /// having to create a new instance.
  SchoolProfilepage copyWith({
    String? schoolId,
    String? schoolName,
    String? schoolCoverImage,
    String? schoolDescription,
    String? schoolPhoneNumber,
    int? schoolStudentCount,
    String? schoolLocation,
    Map<String, dynamic>? averageRating,
    String? schoolEmail,
    List<String>? schoolFeedBacks,
    List<String>? schoolImages,
    List<Teacher>? teachers,
  }) {
    return SchoolProfilepage(
      schoolId: schoolId ?? this.schoolId,
      schoolName: schoolName ?? this.schoolName,
      schoolCoverImage: schoolCoverImage ?? this.schoolCoverImage,
      schoolDescription: schoolDescription ?? this.schoolDescription,
      schoolPhoneNumber: schoolPhoneNumber ?? this.schoolPhoneNumber,
      schoolStudentCount: schoolStudentCount ?? this.schoolStudentCount,
      schoolLocation: schoolLocation ?? this.schoolLocation,
      averageRating: averageRating ?? this.averageRating,
      schoolEmail: schoolEmail ?? this.schoolEmail,
      schoolFeedBacks: schoolFeedBacks ?? this.schoolFeedBacks,
      schoolImages: schoolImages ?? this.schoolImages,
      teachers: teachers ?? this.teachers,
    );
  }

  /// Converts this [SchoolProfilepage] into a map for JSON encoding.
  ///
  /// The map will contain the following keys:
  /// - `schoolId`: The [schoolId].
  /// - `schoolName`: The [schoolName].
  /// - `schoolCoverImage`: The [schoolCoverImage].
  /// - `schoolDescription`: The [schoolDescription].
  /// - `schoolPhoneNumber`: The [schoolPhoneNumber].
  /// - `schoolStudentCount`: The [schoolStudentCount].
  /// - `schoolLocation`: The [schoolLocation].
  /// - `averageRating`: The [averageRating].
  /// - `schoolEmail`: The [schoolEmail].
  /// - `schoolFeedBacks`: The [schoolFeedBacks].
  /// - `schoolImages`: The [schoolImages].
  /// - `teachers`: A list of maps containing the properties of each [Teacher] in [teachers].
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'schoolId': schoolId,
      'schoolName': schoolName,
      'schoolCoverImage': schoolCoverImage,
      'schoolDescription': schoolDescription,
      'schoolPhoneNumber': schoolPhoneNumber,
      'schoolStudentCount': schoolStudentCount,
      'schoolLocation': schoolLocation,
      'averageRating': averageRating,
      'schoolEmail': schoolEmail,
      'schoolFeedBacks': schoolFeedBacks,
      'schoolImages': schoolImages,
      'teachers': teachers.map((x) => x.toMap()).toList(),
    };
  }

  factory SchoolProfilepage.fromMap(Map<String, dynamic> map) {
    return SchoolProfilepage(
      schoolId: map['schoolId'] as String,
      schoolName: map['schoolName'] as String,
      schoolCoverImage: map['schoolCoverImage'] as String,
      schoolDescription: map['schoolDescription'] as String,
      schoolPhoneNumber: map['schoolPhoneNumber'] as String,
      schoolStudentCount: map['schoolStudentCount'] as int,
      schoolLocation: map['schoolLocation'] as String,
      averageRating: map['averageRating'] as Map<String, dynamic>,
      schoolEmail: map['schoolEmail'] as String,
      schoolFeedBacks:
          List<String>.from((map['schoolFeedBacks'] as List<dynamic>)),
      schoolImages: List<String>.from((map['schoolImages'] as List<dynamic>)),
      teachers: List<Teacher>.from(
        (map['teachers'] as List<dynamic>).map<Teacher>(
          (x) => Teacher.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SchoolProfilepage.fromJson(String source) =>
      SchoolProfilepage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  /// Returns a string representation of this [SchoolProfilepage] object.
  ///
  /// The string representation will include all the properties of the
  /// [SchoolProfilepage] object, in the format:
  ///
  /// `SchoolProfilepage(schoolId: $schoolId, schoolName: $schoolName, schoolCoverImage: $schoolCoverImage, schoolDescription: $schoolDescription, schoolPhoneNumber: $schoolPhoneNumber, schoolStudentCount: $schoolStudentCount, schoolLocation: $schoolLocation, averageRating: $averageRating, schoolEmail: $schoolEmail, schoolFeedBacks: $schoolFeedBacks, schoolImages: $schoolImages, teachers: $teachers)`
  String toString() {
    return 'SchoolProfilepage(schoolId: $schoolId, schoolName: $schoolName, schoolCoverImage: $schoolCoverImage, schoolDescription: $schoolDescription, schoolPhoneNumber: $schoolPhoneNumber, schoolStudentCount: $schoolStudentCount, schoolLocation: $schoolLocation, averageRating: $averageRating, schoolEmail: $schoolEmail, schoolFeedBacks: $schoolFeedBacks, schoolImages: $schoolImages, teachers: $teachers)';
  }

  @override
  bool operator ==(covariant SchoolProfilepage other) {
    if (identical(this, other)) return true;

    return other.schoolId == schoolId &&
        other.schoolName == schoolName &&
        other.schoolCoverImage == schoolCoverImage &&
        other.schoolDescription == schoolDescription &&
        other.schoolPhoneNumber == schoolPhoneNumber &&
        other.schoolStudentCount == schoolStudentCount &&
        other.schoolLocation == schoolLocation &&
        other.averageRating == averageRating &&
        other.schoolEmail == schoolEmail &&
        listEquals(other.schoolFeedBacks, schoolFeedBacks) &&
        listEquals(other.schoolImages, schoolImages) &&
        listEquals(other.teachers, teachers);
  }

  @override
  int get hashCode {
    return schoolId.hashCode ^
        schoolName.hashCode ^
        schoolCoverImage.hashCode ^
        schoolDescription.hashCode ^
        schoolPhoneNumber.hashCode ^
        schoolStudentCount.hashCode ^
        schoolLocation.hashCode ^
        averageRating.hashCode ^
        schoolEmail.hashCode ^
        schoolFeedBacks.hashCode ^
        schoolImages.hashCode ^
        teachers.hashCode;
  }
}
