import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';

class GetCarsUseCase {
  final CarRepository repository;

  GetCarsUseCase(this.repository);

  @override
  Future<Either<ErrorModel, List<CarEntity>>> call(
      FilterRequestEntity? params) async {
    return await repository.getCars(params);
  }
}