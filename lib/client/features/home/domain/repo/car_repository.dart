import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

abstract class HomeRepository {
  Future<Either<ErrorModel, List<CarEntity>>> getCars(HomeRequestParams params);
  Future<Either<ErrorModel, FilterInfo>> getFilterInfo();
}
