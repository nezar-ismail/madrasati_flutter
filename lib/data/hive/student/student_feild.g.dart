// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_feild.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUserAdapter extends TypeAdapter<LocalUser> {
  @override
  final int typeId = 0;

  @override
  LocalUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUser(
      userEmail: fields[0] as String?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      imagePath: fields[3] as String?,
      birthDate: fields[4] as String?,
      gender: fields[5] as String?,
      schoolId: fields[6] as String?,
      groupId: fields[7] as String?,
      studentId: fields[8] as String?,
      schoolName: fields[9] as String?,
      isManager:fields[10] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalUser obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.studentId)
      ..writeByte(9)
      ..write(obj.schoolName)
      ..writeByte(10)
      ..write(obj.isManager);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
