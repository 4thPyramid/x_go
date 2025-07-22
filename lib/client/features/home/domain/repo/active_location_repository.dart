import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/home/domain/entity/active_location.dart';

abstract class ActiveLocationRepository {
  Future<Either<ErrorModel, LocationActive>> getActiveLocation();
}
