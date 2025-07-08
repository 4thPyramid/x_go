import 'package:dartz/dartz.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';


abstract class HomeRepository {
  Future<Either<Failure, List<CarEntity>>> getCars(HomeRequestParams params);
  Future<Either<Failure, FilterInfo>> getFilterInfo();
}
