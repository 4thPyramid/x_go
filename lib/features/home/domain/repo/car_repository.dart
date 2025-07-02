import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_info_entity.dart' show FilterInfoEntity;
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';


abstract class CarRepository {
  Future<Either<ErrorModel, List<CarEntity>>> getCars(FilterRequestEntity? filterRequest);
  Future<Either<ErrorModel, FilterInfoEntity>> getFilterInfo();
}
