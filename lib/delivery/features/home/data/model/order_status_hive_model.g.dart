// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderStatusHiveModelAdapter extends TypeAdapter<OrderStatusHiveModel> {
  @override
  final int typeId = 0;

  @override
  OrderStatusHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderStatusHiveModel(
      id: fields[0] as int,
      paymentMethod: fields[1] as String,
      finalPrice: fields[2] as String,
      modelName: fields[3] as String,
      carModelYear: fields[4] as String,
      carModelImage: fields[5] as String,
      carPlateNumber: fields[6] as String,
      carColor: fields[7] as String,
      userName: fields[8] as String,
      userPhone: fields[9] as String,
      driverName: fields[10] as String,
      driverPhone: fields[11] as String,
      location: fields[12] as String,
      averageRating: fields[13] as String?,
      ratingsCount: fields[14] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderStatusHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.paymentMethod)
      ..writeByte(2)
      ..write(obj.finalPrice)
      ..writeByte(3)
      ..write(obj.modelName)
      ..writeByte(4)
      ..write(obj.carModelYear)
      ..writeByte(5)
      ..write(obj.carModelImage)
      ..writeByte(6)
      ..write(obj.carPlateNumber)
      ..writeByte(7)
      ..write(obj.carColor)
      ..writeByte(8)
      ..write(obj.userName)
      ..writeByte(9)
      ..write(obj.userPhone)
      ..writeByte(10)
      ..write(obj.driverName)
      ..writeByte(11)
      ..write(obj.driverPhone)
      ..writeByte(12)
      ..write(obj.location)
      ..writeByte(13)
      ..write(obj.averageRating)
      ..writeByte(14)
      ..write(obj.ratingsCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderStatusHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
