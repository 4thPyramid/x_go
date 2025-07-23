// lib/features/booking/domain/usecases/get_booking_details_usecase.dart
import 'package:x_go/delivery/features/orderDetails/domain/repos/order_details_repo.dart';

import '../entities/booking_entity.dart';

class GetBookingDetailsUseCase {
  final BookingDetailsRepository repository;

  GetBookingDetailsUseCase(this.repository);

  Future<BookingEntity> call(int id) {
    return repository.getBookingDetails(id);
  }
}
