import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_update_request.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_update_entity.dart';

abstract class DriverProfileRepository {
  Future<Either<ErrorModel, DriverProfileEntity>> getDriverProfile();
  Future<Either<ErrorModel, DriverUpdateEntity>> updateDriverProfile({
    required DriverUpdateRequest driverUpdateRequest,
  });
}
