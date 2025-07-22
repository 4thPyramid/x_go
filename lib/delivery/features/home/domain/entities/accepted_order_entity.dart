// accepted_order_entity.dart
// This file defines the AcceptedOrderEntity class, which represents an accepted order in the system.
//// It includes various properties related to the order, such as start date, end date, status, payment method, and more.
class AcceptedOrderEntity {
  final int id;
  final String startDate;
  final String endDate;
  final String status;
  final String paymentMethod;
  final String finalPrice;
  final int carModelId;
  final String modelName;
  final String carModelYear;
  final String carModelImage;
  final String brandName;
  final String carPlateNumber;
  final String carColor;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String driverName;
  final String driverEmail;
  final String driverPhone;
  final String location;
  final String latitude;
  final String longitude;
  final String? averageRating;
  final int? ratingsCount;

  const AcceptedOrderEntity({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.paymentMethod,
    required this.finalPrice,
    required this.carModelId,
    required this.modelName,
    required this.carModelYear,
    required this.carModelImage,
    required this.brandName,
    required this.carPlateNumber,
    required this.carColor,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.driverName,
    required this.driverEmail,
    required this.driverPhone,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.averageRating,
    this.ratingsCount,
  });
}
