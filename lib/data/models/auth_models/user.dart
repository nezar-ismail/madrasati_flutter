import 'dart:convert';

class Student {
  String? userEmail;
  String? firstName;
  String? lastName;
  String? imagePath;
  DateTime? birthDate;
  String? gender;
  Student({
    this.userEmail,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.birthDate,
    this.gender,
  });

  /// Creates a copy of this [Student] but with the given fields replaced with the
  /// new values.
  ///
  /// The [userEmail], [firstName], [lastName], [imagePath], [birthDate], and
  /// [gender] parameter are all optional and default to the value of the
  /// current object if not provided.
  Student copyWith({
    String? userEmail,
    String? firstName,
    String? lastName,
    String? imagePath,
    DateTime? birthDate,
    String? gender,
  }) {
    return Student(
      userEmail: userEmail ?? this.userEmail,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imagePath: imagePath ?? this.imagePath,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  /// Converts this [Student] into a map for JSON encoding.
  ///
  /// The map will contain the following keys:
  /// - `userEmail`: The [userEmail].
  /// - `firstName`: The [firstName].
  /// - `lastName`: The [lastName].
  /// - `imagePath`: The [imagePath].
  /// - `birthDate`: The [birthDate] in milliseconds since the epoch.
  /// - `gender`: The [gender].
  ///
  /// The values of these keys will be `null` if the respective field
  /// is `null`.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'firstName': firstName,
      'lastName': lastName,
      'imagePath': imagePath,
      'birthDate': birthDate?.millisecondsSinceEpoch,
      'gender': gender,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      birthDate: map['birthDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthDate'] as int)
          : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userEmail: $userEmail, firstName: $firstName, lastName: $lastName, imagePath: $imagePath, birthDate: $birthDate, gender: $gender)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.userEmail == userEmail &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.imagePath == imagePath &&
        other.birthDate == birthDate &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return userEmail.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        imagePath.hashCode ^
        birthDate.hashCode ^
        gender.hashCode;
  }
}
