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
  double averageRating;
  String schoolEmail;
  List<String> schoolFeedBacks;
  List<String> schoolImages;
  Set<Teacher> teachers;
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

  SchoolProfilepage copyWith({
    String? schoolId,
    String? schoolName,
    String? schoolCoverImage,
    String? schoolDescription,
    String? schoolPhoneNumber,
    int? schoolStudentCount,
    String? schoolLocation,
    double? averageRating,
    String? schoolEmail,
    List<String>? schoolFeedBacks,
    List<String>? schoolImages,
    Set<Teacher>? teachers,
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
      averageRating: map['averageRating'] as double,
      schoolEmail: map['schoolEmail'] as String,
      schoolFeedBacks: List<String>.from((map['schoolFeedBacks'] as List<dynamic>)),
      schoolImages: List<String>.from((map['schoolImages'] as List<dynamic>)),
      teachers: Set<Teacher>.from(
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
        setEquals(other.teachers, teachers);
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
