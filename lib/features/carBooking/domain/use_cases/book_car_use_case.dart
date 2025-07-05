import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/carBooking/domain/repository/car_booking_repo.dart';

class BookCarUseCase {
  final CarBookingRepo carBookingRepo;

  BookCarUseCase(this.carBookingRepo);

  Future<Either<ErrorModel, void>> call({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String lat,
    required String long,
    required String location,
  }) async {
    return await carBookingRepo.bookCar(
      carId: carId,
      startDate: startDate,
      endDate: endDate,
      isAdditionalDriverChecked: isAdditionalDriverChecked,
      lat: lat,
      long: long,
      location: location,
    );
  }
}
