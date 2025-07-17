import 'package:dartz/dartz.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';

class GetFilterInfoUseCase implements UseCase<FilterInfo, NoParams> {
  final HomeRepository repository;

  GetFilterInfoUseCase(this.repository);

  @override
  Future<Either<Failure, FilterInfo>> call(NoParams params) async {
    return await repository.getFilterInfo();
  }
}
