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

  final int? modelNameId;
  final String? modelName;

  final int? typeId;
  final String? typeName;
  final String? typeDescription;

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
    final carModel = json['car_model'] as Map<String, dynamic>? ?? {};
    final attributes = carModel['attributes'] as Map<String, dynamic>? ?? {};
    final relationships =
        carModel['relationship'] as Map<String, dynamic>? ?? {};

    final modelNameMap =
        relationships['Model Names'] as Map<String, dynamic>? ?? {};
    final typeMap = relationships['Types'] as Map<String, dynamic>? ?? {};
    final brandMap = relationships['Brand'] as Map<String, dynamic>? ?? {};

    return MyBookingModel(
      id: json['id'] ?? 0,
      carId: json['car_id'] ?? 0,
      userId: (json['user'] != null && json['user']['id'] != null)
          ? int.tryParse(json['user']['id'].toString()) ?? 0
          : 0,
      driverId: json['driver_id'] ?? 0,
      startDate: json['start_date']?.toString() ?? '',
      endDate: json['end_date']?.toString() ?? '',
      finalPrice: json['final_price']?.toString() ?? '0',
      status: json['status']?.toString() ?? 'pending',
      additionalDriver: json['additional_driver'] ?? 0,
      paymentMethod: json['payment_method']?.toString(),
      paymentStatus: json['payment_status']?.toString(),
      transactionId: json['transaction_id']?.toString(),
      carModelId: int.tryParse(carModel['id']?.toString() ?? '') ?? 0,
      locationId: json['location']?['id'],

      // بيانات السيارة
      carModelInternalId: int.tryParse(carModel['id']?.toString() ?? ''),
      carYear: attributes['year']?.toString(),
      carCount: null, // غير موجودة في response
      carPrice: attributes['price']?.toString(),
      carImage: attributes['image']?.toString(),
      engineType: attributes['engine_type']?.toString(),
      transmissionType: attributes['transmission_type']?.toString(),
      seatType: attributes['seat_type']?.toString(),
      seatsCount: attributes['seats_count'],
      acceleration: attributes['acceleration']?.toString(),

      modelNameId: int.tryParse(
        modelNameMap['model_name_id']?.toString() ?? '',
      ),
      modelName: modelNameMap['model_name']?.toString(),

      typeId: int.tryParse(typeMap['type_id']?.toString() ?? ''),
      typeName: typeMap['type_name']?.toString(),
      typeDescription: '',
      brandId: int.tryParse(brandMap['brand_id']?.toString() ?? ''),
      brandName: brandMap['brand_name']?.toString(),
      brandLogo: '',
    );
  }
}
