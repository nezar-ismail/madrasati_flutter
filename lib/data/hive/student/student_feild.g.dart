// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_feild.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalStudentAdapter extends TypeAdapter<LocalStudent> {
  @override
  final int typeId = 0;

  @override
  /// Reads a [LocalStudent] from the given [BinaryReader].
  ///
  /// The read fields are:
  ///
  /// 1. [userEmail]
  /// 2. [firstName]
  /// 3. [lastName]
  /// 4. [imagePath]
  /// 5. [birthDate]
  /// 6. [gender]
  /// 7. [schoolId]
  /// 8. [groupId]
  /// 9. [studentId]
  LocalStudent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStudent(
      userEmail: fields[0] as String?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      imagePath: fields[3] as String?,
      birthDate: fields[4] as String?,
      gender: fields[5] as String?,
      schoolId: fields[6] as String?,
      groupId: fields[7] as String?,
      studentId: fields[8] as String?,
    );
  }

  @override
  /// Writes the given [LocalStudent] to the [BinaryWriter].
  ///
  /// The order of the fields is as follows:
  ///
  /// 1. [userEmail]
  /// 2. [firstName]
  /// 3. [lastName]
  /// 4. [imagePath]
  /// 5. [birthDate]
  /// 6. [gender]
  /// 7. [schoolId]
  /// 8. [groupId]
  /// 9. [studentId]
  void write(BinaryWriter writer, LocalStudent obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userEmail)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.birthDate)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.schoolId)
      ..writeByte(7)
      ..write(obj.groupId)
      ..writeByte(8)
      ..write(obj.studentId);

  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId ;
}
