import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';

abstract class BookingRepository {
  Future<Either<ErrorModel, List<BookingModel>>> getBookingList();
}
