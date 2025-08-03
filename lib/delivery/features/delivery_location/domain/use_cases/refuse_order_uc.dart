import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/delivery_location/domain/repositories/driver_location_repo.dart';

class RefuseOrderUc {
  final DriverLocationRepo driverLocationRepository;

  RefuseOrderUc(this.driverLocationRepository);

  Future<Either<ErrorModel, void>> call(String bookingId) async {
    return await driverLocationRepository.refuseOrder(bookingId);
  }
}
