import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/client/features/carBooking/domain/repository/car_booking_repo.dart';

class BookCarUseCase {
  final CarBookingRepo carBookingRepo;

  BookCarUseCase(this.carBookingRepo);

  Future<Either<ErrorModel, BookingModel>> call({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String locationId,
    required String modelId,
  }) async {
    return await carBookingRepo.bookCar(
      carId: carId,
      startDate: startDate,
      endDate: endDate,
      isAdditionalDriverChecked: isAdditionalDriverChecked,
      locationId: locationId,
      modelId: modelId,
    );
  }
}
