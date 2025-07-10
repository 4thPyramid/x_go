import 'package:dartz/dartz.dart';
import 'package:x_go/features/home/domain/entity/active_location.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';

abstract class ActiveLocationRepository {
  Future<Either<Failure, LocationActive>> getActiveLocation();
}
