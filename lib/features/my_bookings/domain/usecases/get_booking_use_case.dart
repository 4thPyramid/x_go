import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/my_bookings/domain/repos/booking_repo.dart';

class GetBookingList {
  final BookingRepository repository;

  GetBookingList(this.repository);

  Future<List<Booking>> call() {
    return repository.getBookingList();
  }
}
