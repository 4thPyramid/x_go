import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/carBooking/data/model/locations_model.dart';

abstract class CarBookingRepo {
  Future<Either<ErrorModel, BookingModel>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,

    required String locationId,
    required String modelId,
  });
  Future<Either<ErrorModel, LocationsModel>> getLocations();
}
