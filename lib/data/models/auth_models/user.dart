import 'dart:convert';

class User {
  String? userEmail;
  String? firstName;
  String? lastName;
  String? imagePath;
  DateTime? birthDate;
  String? gender;
  User({
    this.userEmail,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.birthDate,
    this.gender,
  });

  User copyWith({
    String? userEmail,
    String? firstName,
    String? lastName,
    String? imagePath,
    DateTime? birthDate,
    String? gender,
  }) {
    return User(
      userEmail: userEmail ?? this.userEmail,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imagePath: imagePath ?? this.imagePath,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userEmail: $userEmail, firstName: $firstName, lastName: $lastName, imagePath: $imagePath, birthDate: $birthDate, gender: $gender)';
  }

  @override
  bool operator ==(covariant User other) {
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
