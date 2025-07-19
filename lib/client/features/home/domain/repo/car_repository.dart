import 'package:dartz/dartz.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CarEntity>>> getCars(HomeRequestParams params);
  Future<Either<Failure, FilterInfo>> getFilterInfo();
}
