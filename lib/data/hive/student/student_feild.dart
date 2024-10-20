import 'package:hive/hive.dart';

part 'student_feild.g.dart';// Ensure this is present

@HiveType(typeId: 0) // Use a unique typeId
class LocalStudent {
  @HiveField(0)
  String? userEmail;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? imagePath;

  @HiveField(4)
  DateTime? birthDate;

  @HiveField(5)
  String? gender;

  LocalStudent({
    this.userEmail,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.birthDate,
    this.gender,
  });
}
