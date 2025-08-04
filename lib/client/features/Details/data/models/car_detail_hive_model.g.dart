// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_detail_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarDetailHiveModelAdapter extends TypeAdapter<CarDetailHiveModel> {
  @override
  final int typeId = 1;

  @override
  CarDetailHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarDetailHiveModel(
      modelName: fields[0] as String,
      type: fields[1] as String,
      brand: fields[2] as String,
      averageRating: fields[3] as String,
      year: fields[4] as String,
      price: fields[5] as String,
      engineType: fields[6] as String,
      transmissionType: fields[7] as String,
      seatType: fields[8] as String,
      seatsCount: fields[9] as int,
      acceleration: fields[10] as String,
      image: fields[11] as String,
      ratingsCount: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CarDetailHiveModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.modelName)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.averageRating)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.engineType)
      ..writeByte(7)
      ..write(obj.transmissionType)
      ..writeByte(8)
      ..write(obj.seatType)
      ..writeByte(9)
      ..write(obj.seatsCount)
      ..writeByte(10)
      ..write(obj.acceleration)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.ratingsCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarDetailHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
