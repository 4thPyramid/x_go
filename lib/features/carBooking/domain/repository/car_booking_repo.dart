import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';

abstract class CarBookingRepo {
  Future<Either<ErrorModel, void>> setLocation({
    required String latitude,
    required String longitude,
    required String location,
  });
  Future<Either<ErrorModel, void>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
  });
}
