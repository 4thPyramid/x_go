import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';
import 'package:x_go/delivery/features/profile/domain/repos/driver_profile_repo.dart';

class DriverProfileUseCase implements UseCase<DriverProfileEntity, NoParams> {
  final DriverProfileRepository _repository;
  DriverProfileUseCase(this._repository);

  @override
  Future<Either<ErrorModel, DriverProfileEntity>> call(NoParams params) async {
    return await _repository.getDriverProfile();
  }
}
