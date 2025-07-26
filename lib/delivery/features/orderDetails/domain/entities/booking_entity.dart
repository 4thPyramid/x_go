import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

class BookingEntity extends Equatable {
  final int id;
  final String startDate;
  final String endDate;
  final String finalPrice;
  final String status;
  final String paymentMethod;
  final String? paymentStatus;
  final String? transactionId;
  final CarModel carModel;
  final UserModel user;
  final CarModelSimple car;
  final LocationModel? location;  // <- لازم تكون موجودة هنا
 
  const BookingEntity({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.finalPrice,
    required this.status,
    required this.paymentMethod,
    this.paymentStatus,
    this.transactionId,
    required this.carModel,
    required this.user,
    required this.car,
    this.location,  
  });

  @override
  List<Object?> get props => [id, status];
}
