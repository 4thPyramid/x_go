// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_active_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationActiveHiveModelAdapter
    extends TypeAdapter<LocationActiveHiveModel> {
  @override
  final int typeId = 4;

  @override
  LocationActiveHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationActiveHiveModel(
      id: fields[0] as int,
      location: fields[1] as String,
      latitude: fields[2] as String,
      longitude: fields[3] as String,
      isActive: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocationActiveHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationActiveHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
