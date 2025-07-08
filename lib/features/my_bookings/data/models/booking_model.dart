import 'package:x_go/features/my_bookings/domain/entities/booking_intity.dart';

class BookingModel {
  final int bookingId;
  final String startDate;
  final String endDate;
  final String finalPrice;
  final String status;
  final String carName;
  final String brandName;
  final String carImage;

  BookingModel({
    required this.bookingId,
    required this.startDate,
    required this.endDate,
    required this.finalPrice,
    required this.status,
    required this.carName,
    required this.brandName,
    required this.carImage,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final model = json['model'];
    final attributes = model?['attributes'] ?? {};
    final relationship = model?['relationship'] ?? {};
    final brand = relationship['Brand'] ?? {};

    return BookingModel(
      bookingId: json['booking_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      finalPrice: json['final_price'],
      status: json['status'],
      carName: attributes['name'] ?? '',
      brandName: brand['brand_name'] ?? '',
      carImage: attributes['image'] ?? '',
    );
  }

  BookingIntity toEntity() {
    return BookingIntity(
      bookingId: bookingId,
      startDate: startDate,
      endDate: endDate,
      finalPrice: finalPrice,
      status: status,
      carName: carName,
      brandName: brandName,
      carImage: carImage,
    );
  }
}
