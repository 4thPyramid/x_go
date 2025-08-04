// data/models/car_detail_hive_model.dart

import 'package:hive/hive.dart';

part 'car_detail_hive_model.g.dart';

@HiveType(typeId: 1)
class CarDetailHiveModel extends HiveObject {
  @HiveField(0)
  final String modelName;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String brand;

  @HiveField(3)
  final String averageRating;

  @HiveField(4)
  final String year;

  @HiveField(5)
  final String price;

  @HiveField(6)
  final String engineType;

  @HiveField(7)
  final String transmissionType;

  @HiveField(8)
  final String seatType;

  @HiveField(9)
  final int seatsCount;

  @HiveField(10)
  final String acceleration;

  @HiveField(11)
  final String image;

  @HiveField(12)
  final int ratingsCount;

  CarDetailHiveModel({
    required this.modelName,
    required this.type,
    required this.brand,
    required this.averageRating,
    required this.year,
    required this.price,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
    required this.seatsCount,
    required this.acceleration,
    required this.image,
    required this.ratingsCount,
  });
}
