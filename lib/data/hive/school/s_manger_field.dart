import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LocalSManger {
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

  LocalSManger({
    this.userEmail,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.birthDate,
    this.gender,
    this.schoolId,
    this.groupId,
  });
}
