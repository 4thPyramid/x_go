import 'package:hive/hive.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

part 'order_status_hive_model.g.dart';

@HiveType(typeId: 0)
class OrderStatusHiveModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String paymentMethod;
  @HiveField(2)
  final String finalPrice;
  @HiveField(3)
  final String modelName;
  @HiveField(4)
  final String carModelYear;
  @HiveField(5)
  final String carModelImage;
  @HiveField(6)
  final String carPlateNumber;
  @HiveField(7)
  final String carColor;
  @HiveField(8)
  final String userName;
  @HiveField(9)
  final String userPhone;
  @HiveField(10)
  final String driverName;
  @HiveField(11)
  final String driverPhone;
  @HiveField(12)
  final String location;
  @HiveField(13)
  final String? averageRating;
  @HiveField(14)
  final int? ratingsCount;

  OrderStatusHiveModel({
    required this.id,
    required this.paymentMethod,
    required this.finalPrice,
    required this.modelName,
    required this.carModelYear,
    required this.carModelImage,
    required this.carPlateNumber,
    required this.carColor,
    required this.userName,
    required this.userPhone,
    required this.driverName,
    required this.driverPhone,
    required this.location,
    this.averageRating,
    this.ratingsCount,
  });

  factory OrderStatusHiveModel.fromEntity(OrderStatusEntity entity) {
    return OrderStatusHiveModel(
      id: entity.id,
      paymentMethod: entity.paymentMethod,
      finalPrice: entity.finalPrice,
      modelName: entity.modelName,
      carModelYear: entity.carModelYear,
      carModelImage: entity.carModelImage,
      carPlateNumber: entity.carPlateNumber,
      carColor: entity.carColor,
      userName: entity.userName,
      userPhone: entity.userPhone,
      driverName: entity.driverName,
      driverPhone: entity.driverPhone,
      location: entity.location,
      averageRating: entity.averageRating,
      ratingsCount: entity.ratingsCount,
    );
  }

  OrderStatusEntity toEntity() {
    return OrderStatusEntity(
      id: id,
      paymentMethod: paymentMethod,
      finalPrice: finalPrice,
      modelName: modelName,
      carModelYear: carModelYear,
      carModelImage: carModelImage,
      carPlateNumber: carPlateNumber,
      carColor: carColor,
      userName: userName,
      userPhone: userPhone,
      driverName: driverName,
      driverPhone: driverPhone,
      location: location,
      averageRating: averageRating,
      ratingsCount: ratingsCount,
    );
  }
}
