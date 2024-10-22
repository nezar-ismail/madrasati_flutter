import 'dart:convert';

class Teacher {
  String teacherName;
  String teacherSubject;
  int teacherExperience;
  String teacherDescription;
  String teacherImage;
  Teacher({
    required this.teacherName,
    required this.teacherSubject,
    required this.teacherExperience,
    required this.teacherDescription,
    required this.teacherImage,
  });

  Teacher copyWith({
    String? teacherName,
    String? teacherSubject,
    int? teacherExperience,
    String? teacherDescription,
    String? teacherImage,
  }) {
    return Teacher(
      teacherName: teacherName ?? this.teacherName,
      teacherSubject: teacherSubject ?? this.teacherSubject,
      teacherExperience: teacherExperience ?? this.teacherExperience,
      teacherDescription: teacherDescription ?? this.teacherDescription,
      teacherImage: teacherImage ?? this.teacherImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teacherName': teacherName,
      'teacherSubject': teacherSubject,
      'teacherExperience': teacherExperience,
      'teacherDescription': teacherDescription,
      'teacherImage': teacherImage,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      teacherName: map['teacherName'] as String,
      teacherSubject: map['teacherSubject'] as String,
      teacherExperience: map['teacherExperience'] as int,
      teacherDescription: map['teacherDescription'] as String,
      teacherImage: map['teacherImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Teacher(teacherName: $teacherName, teacherSubject: $teacherSubject, teacherExperience: $teacherExperience, teacherDescription: $teacherDescription, teacherImage: $teacherImage)';
  }

  @override
  bool operator ==(covariant Teacher other) {
    if (identical(this, other)) return true;

    return other.teacherName == teacherName &&
        other.teacherSubject == teacherSubject &&
        other.teacherExperience == teacherExperience &&
        other.teacherDescription == teacherDescription &&
        other.teacherImage == teacherImage;
  }

  @override
  int get hashCode {
    return teacherName.hashCode ^
        teacherSubject.hashCode ^
        teacherExperience.hashCode ^
        teacherDescription.hashCode ^
        teacherImage.hashCode;
  }
}
