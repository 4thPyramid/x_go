import 'package:dartz/dartz.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/features/home/domain/entity/active_location.dart';
import 'package:x_go/features/home/domain/repo/active_location_repository.dart';

class GetActiveLocationUseCase implements UseCase<LocationActive, NoParams> {
  final ActiveLocationRepository repository;

  GetActiveLocationUseCase(this.repository);

  @override
  Future<Either<Failure, LocationActive>> call(NoParams params) async {
    return await repository.getActiveLocation();
  }
}
