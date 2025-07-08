import 'package:x_go/features/carBooking/data/model/book_car_model.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBookingList();
}
