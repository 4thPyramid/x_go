import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/features/my_bookings/domain/repos/booking_repo.dart';

class GetBookingList {
  final BookingRepository repository;

  GetBookingList(this.repository);

  Future<Either<ErrorModel, List<BookingModel>>> call() async {
    return await repository.getBookingList();
  }
}
