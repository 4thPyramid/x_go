import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';

abstract class DriverProfileRepository {
  Future<Either<ErrorModel, DriverProfileEntity>> getDriverProfile();
}
