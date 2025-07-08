import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
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

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}
