import 'package:dartz/dartz.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';

class GetCarsUseCase implements UseCase<List<CarEntity>, HomeRequestParams> {
  final HomeRepository repository;

  GetCarsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CarEntity>>> call(
    HomeRequestParams params,
  ) async {
    return await repository.getCars(params);
  }
}
