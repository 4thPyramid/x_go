import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';

abstract class LocationRepo {
  Future<Either<ErrorModel, void>> setLocation({
    required String latitude,
    required String longitude,
    required String location,
    required bool isActive,
  });
}
