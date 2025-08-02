// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverProfileHiveModelAdapter
    extends TypeAdapter<DriverProfileHiveModel> {
  @override
  final int typeId = 5;

  @override
  DriverProfileHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DriverProfileHiveModel(
      id: fields[0] as int,
      name: fields[1] as String?,
      email: fields[2] as String?,
      phone: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DriverProfileHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverProfileHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
