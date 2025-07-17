import 'package:dartz/dartz.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/features/home/domain/entity/active_location.dart';

abstract class ActiveLocationRepository {
  Future<Either<Failure, LocationActive>> getActiveLocation();
}
