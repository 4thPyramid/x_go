import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/home/data/datasources/car_remote_datasource.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_info_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final CarRemoteDatasource remoteDatasource;

  CarRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<ErrorModel, List<CarEntity>>> getCars(
    FilterRequestEntity? filterRequest,
  ) async {
    try {
      final response = await remoteDatasource.getCars(filterRequest);
      return Right(response.data);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, FilterInfoEntity>> getFilterInfo() async {
    try {
      final response = await remoteDatasource.getFilterInfo();
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
