import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_update_request.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_update_entity.dart';
import 'package:x_go/delivery/features/profile/domain/repos/driver_profile_repo.dart';

class DriverUpdateUseCase
    implements UseCase<DriverUpdateEntity, DriverUpdateRequest> {
  final DriverProfileRepository repository;

  DriverUpdateUseCase(this.repository);

  @override
  Future<Either<ErrorModel, DriverUpdateEntity>> call(
    DriverUpdateRequest driverUpdateRequest,
  ) {
    return repository.updateDriverProfile(
      driverUpdateRequest: driverUpdateRequest,
    );
  }
}
