// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_feild.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalStudentAdapter extends TypeAdapter<LocalStudent> {
  @override
  final int typeId = 0;

  @override
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
      birthDate: fields[4] as DateTime?,
      gender: fields[5] as String?,
    );
  }

  @override
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
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
