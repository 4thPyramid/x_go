import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/carBooking/data/data_source/remote_data_source.dart';
import 'package:x_go/features/carBooking/domain/repository/car_booking_repo.dart';

class CarBookingRepoImpl implements CarBookingRepo {
  final CarBookingRemoteDataSource remoteDataSource;

  CarBookingRepoImpl(this.remoteDataSource);
  @override
  @override
  Future<Either<ErrorModel, void>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
  }) {
    return remoteDataSource.bookCar(
      carId: carId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
