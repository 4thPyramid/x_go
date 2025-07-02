import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/home/domain/entity/filter_info_entity.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';

class GetFilterInfoUseCase {
  final CarRepository repository;

  GetFilterInfoUseCase(this.repository);

  @override
  Future<Either<ErrorModel, FilterInfoEntity>> calls() async {
    return await repository.getFilterInfo();
  }
}