import 'package:dartz/dartz.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';


class GetCarsUseCase implements UseCase<List<CarEntity>, HomeRequestParams> {
  final HomeRepository repository;

  GetCarsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CarEntity>>> call(HomeRequestParams params) async {
    return await repository.getCars(params);
  }
}
