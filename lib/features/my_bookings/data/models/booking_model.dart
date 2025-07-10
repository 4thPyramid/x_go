import 'package:equatable/equatable.dart';

class BookingModel extends Equatable {
  final String startDate;
  final String endDate;
  final String status;
  final String finalPrice;
  final String carModelYear;
  final String carImage;
  final String modelName;
  final String brandName;

  const BookingModel({
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.finalPrice,
    required this.carModelYear,
    required this.carImage,
    required this.modelName,
    required this.brandName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? '',
      finalPrice: json['final_price'] ?? '',
      carModelYear: json['car_model_year'] ?? '',
      carImage: json['car_model_image'] ?? '',
      modelName: json['model_name'] ?? '',
      brandName: json['brand_name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        status,
        finalPrice,
        carModelYear,
        carImage,
        modelName,
        brandName,
      ];

  @override
  String toString() {
    return 'BookingModel(status: $status, car: $brandName $modelName $carModelYear)';
  }
}
