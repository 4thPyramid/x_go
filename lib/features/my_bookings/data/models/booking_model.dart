class MyBookingModel {
  final int id;
  final String startDate;
  final String endDate;
  final String status;
  final String finalPrice;
  final String carModelYear;
  final String carModelImage;
  final int carModelId;
  final String modelName;
  final String brandName;

  MyBookingModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.finalPrice,
    required this.carModelYear,
    required this.carModelImage,
    required this.carModelId,
    required this.modelName,
    required this.brandName,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    return MyBookingModel(
      id: json['id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['status'],
      finalPrice: json['final_price'],
      carModelYear: json['car_model_year'],
      carModelImage: json['car_model_image'],
      carModelId: json['car_model_id'],
      modelName: json['model_name'],
      brandName: json['brand_name'],
    );
  }
}
