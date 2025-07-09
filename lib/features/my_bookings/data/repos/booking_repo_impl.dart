import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/features/my_bookings/data/remote_d_s/booking_remote_d_s.dart';
import 'package:x_go/features/my_bookings/domain/repos/booking_repo.dart';

class BookingRepoImpl extends BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorModel, List<BookingModel>>> getBookingList() async {
    try {
      final bookings = await remoteDataSource.getBookingList();
      return Right(bookings);
    } catch (error) {
      return Left(ErrorModel(message: error.toString()));
    }
  }
}
