// accepted_order_entity.dart
// This file defines the AcceptedOrderEntity class, which represents an accepted order in the system.
class OrderStatusEntity {
  final int id;
  final String paymentMethod;
  final String finalPrice;
  final String modelName;
  final String carModelYear;
  final String carModelImage;
  final String carPlateNumber;
  final String carColor;
  final String userName;
  final String userPhone;
  final String driverName;
  final String driverPhone;
  final String location;
  final String? averageRating;
  final int? ratingsCount;

  const OrderStatusEntity({
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
}
