import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/carBooking/domain/repository/car_booking_repo.dart';
import 'package:x_go/features/location/domain/repository/location_repo.dart';

class SetLocationUseCase {
  final LocationRepo locationRepo;

  SetLocationUseCase(this.locationRepo);

  Future<Either<ErrorModel, void>> call({
    required String latitude,
    required String longitude,
    required String location,
    required bool isActive,
  }) async {
    return await locationRepo.setLocation(
      latitude: latitude,
      longitude: longitude,
      location: location,
      isActive: isActive,
    );
  }
}
