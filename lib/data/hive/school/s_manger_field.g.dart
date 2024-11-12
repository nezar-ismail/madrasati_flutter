// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's_manger_field.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalSchoolMangerAdapter extends TypeAdapter<LocalSchoolManger> {
  @override
  final int typeId = 0;

  @override
  LocalSchoolManger read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalSchoolManger(
      userEmail: fields[0] as String?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      imagePath: fields[3] as String?,
      birthDate: fields[4] as String?,
      gender: fields[5] as String?,
      schoolId: fields[6] as String?,
      groupId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalSchoolManger obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.groupId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalSchoolMangerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
