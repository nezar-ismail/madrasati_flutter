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

  /// Creates a copy of this [Teacher] but with the given fields replaced with
  /// the new values.
  ///
  /// If a field is not provided, it will keep its current value from the 
  /// existing [Teacher] instance.
  ///
  /// This method is useful when you need to update a [Teacher] object without
  /// having to create a new instance.
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

  /// Converts this [Teacher] into a map for JSON encoding.
  ///
  /// The map will contain the following keys:
  /// - `teacherName`: The [teacherName].
  /// - `teacherSubject`: The [teacherSubject].
  /// - `teacherExperience`: The [teacherExperience].
  /// - `teacherDescription`: The [teacherDescription].
  /// - `teacherImage`: The [teacherImage].
  ///
  /// The values of these keys will be `null` if the respective field
  /// is `null`.
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
/// Returns a string representation of the [Teacher] object, including
/// all its fields such as teacherName, teacherSubject, teacherExperience,
/// teacherDescription, and teacherImage.
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
