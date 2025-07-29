import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/client/features/my_bookings/data/remote_d_s/booking_remote_d_s.dart';
import 'package:x_go/client/features/my_bookings/domain/repos/booking_repo.dart';

class BookingRepoImpl extends BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorModel, List<MyBookingModel>>> getBookingList() async {
    try {
      final bookings = await remoteDataSource.getBookingList();
      return Right(bookings);
    } catch (error) {
      return Left(ErrorModel(message: _mapError(error)));
    }
  }

  String _mapError(Object error) {
    if (error is DioException) {
      return error.response?.data['message']?.toString() ??
          'Network error occurred';
    }
    return error.toString();
  }
}
