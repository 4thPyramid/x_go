import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/carBooking/data/model/locations_model.dart';
import 'package:x_go/features/carBooking/domain/repository/car_booking_repo.dart';

class GetLocationsUseCase {
  final CarBookingRepo carBookingRepo;

  GetLocationsUseCase(this.carBookingRepo);

  Future<Either<ErrorModel, LocationsModel>> call() async {
    return await carBookingRepo.getLocations();
  }
}
