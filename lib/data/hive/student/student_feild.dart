import 'package:hive/hive.dart';

part 'student_feild.g.dart';// Ensure this is present

@HiveType(typeId: 0) // Use a unique typeId
class LocalUser {
  @HiveField(0)
  String? userEmail;

  @HiveField(1)
  String? firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? imagePath;

  @HiveField(4)
  String? birthDate;

  @HiveField(5)
  String? gender;

    @HiveField(6)
  String? schoolId;

  @HiveField(7)
  String? groupId;

  @HiveField(8)
  String? studentId;

  @HiveField(9)
  String? schoolName;

  @HiveField(10)
  bool? isManager;

  LocalUser({
    this.userEmail,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.birthDate,
    this.gender,
    this.schoolId,
    this.groupId,
    this.studentId,
    this.schoolName,
    this.isManager
  });
}
