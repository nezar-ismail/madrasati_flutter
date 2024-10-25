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

  LocalSManger({
    this.userEmail,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.birthDate,
    this.gender,
  });
}
