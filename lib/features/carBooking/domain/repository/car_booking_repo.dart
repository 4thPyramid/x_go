import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';

abstract class CarBookingRepo {
  Future<Either<ErrorModel, void>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String lat,
    required String long,
    required String location,
  });
}
