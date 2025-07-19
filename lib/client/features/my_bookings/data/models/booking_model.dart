class MyBookingModel {
  final int id;
  final int? carId;
  final int userId;
  final int? driverId;
  final String startDate;
  final String endDate;
  final String finalPrice;
  final String status;
  final int additionalDriver;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? transactionId;
  final int carModelId;
  final int? locationId;

  // بيانات السيارة
  final int? carModelInternalId;
  final String? carYear;
  final int? carCount;
  final String? carPrice;
  final String? carImage;
  final String? engineType;
  final String? transmissionType;
  final String? seatType;
  final int? seatsCount;
  final String? acceleration;

  // بيانات الموديل
  final int? modelNameId;
  final String? modelName;

  // بيانات النوع
  final int? typeId;
  final String? typeName;
  final String? typeDescription;

  // بيانات الماركة
  final int? brandId;
  final String? brandName;
  final String? brandLogo;

  MyBookingModel({
    required this.id,
    required this.carId,
    required this.userId,
    required this.driverId,
    required this.startDate,
    required this.endDate,
    required this.finalPrice,
    required this.status,
    required this.additionalDriver,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.transactionId,
    required this.carModelId,
    required this.locationId,
    required this.carModelInternalId,
    required this.carYear,
    required this.carCount,
    required this.carPrice,
    required this.carImage,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
    required this.seatsCount,
    required this.acceleration,
    required this.modelNameId,
    required this.modelName,
    required this.typeId,
    required this.typeName,
    required this.typeDescription,
    required this.brandId,
    required this.brandName,
    required this.brandLogo,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    final carModel = json['car_model'];
    final modelName = carModel != null ? carModel['model_name'] : null;
    final type = modelName != null ? modelName['type'] : null;
    final brand = type != null ? type['brand'] : null;

    return MyBookingModel(
      id: json['id'],
      carId: json['car_id'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      finalPrice: json['final_price'],
      status: json['status'],
      additionalDriver: json['additional_driver'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      transactionId: json['transaction_id'],
      carModelId: json['carmodel_id'],
      locationId: json['location_id'],

      // بيانات السيارة
      carModelInternalId: carModel?['id'],
      carYear: carModel?['year'],
      carCount: carModel?['count'],
      carPrice: carModel?['price'],
      carImage: carModel?['image'],
      engineType: carModel?['engine_type'],
      transmissionType: carModel?['transmission_type'],
      seatType: carModel?['seat_type'],
      seatsCount: carModel?['seats_count'],
      acceleration: carModel?['acceleration'],

      // بيانات الموديل
      modelNameId: modelName?['id'],
      modelName: modelName?['name'],

      // بيانات النوع
      typeId: type?['id'],
      typeName: type?['name'],
      typeDescription: type?['description'],

      // بيانات الماركة
      brandId: brand?['id'],
      brandName: brand?['name'],
      brandLogo: brand?['logo'],
    );
  }
}
