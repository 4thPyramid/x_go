import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/carBooking/data/data_source/remote_data_source.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/carBooking/data/model/locations_model.dart';
import 'package:x_go/features/carBooking/domain/repository/car_booking_repo.dart';

class CarBookingRepoImpl implements CarBookingRepo {
  final CarBookingRemoteDataSource remoteDataSource;

  CarBookingRepoImpl(this.remoteDataSource);
  @override
  @override
  Future<Either<ErrorModel, BookingModel>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String locationId,
    required String modelId,
  }) {
    return remoteDataSource.bookCar(
      carId: carId,
      startDate: startDate,
      endDate: endDate,
      isAdditionalDriverChecked: isAdditionalDriverChecked,
      locationId: locationId,
      modelId: modelId,
    );
  }

  @override
  Future<Either<ErrorModel, LocationsModel>> getLocations() {
    return remoteDataSource.getLocations();
  }
}
