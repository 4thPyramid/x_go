import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/client/features/home/data/datasources/car_remote_datasource_impl.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import 'package:x_go/client/features/home/domain/repo/car_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ErrorModel, List<CarEntity>>> getCars(
    HomeRequestParams params,
  ) async {
    try {
      final response = await remoteDataSource.getCars(params);

      // Convert to entities
      final cars = response.data
          .map((carModel) => carModel.toEntity())
          .toList();

      // Remove duplicates based on car id
      final uniqueCars = <String, CarEntity>{};
      for (var car in cars) {
        uniqueCars[car.id] = car;
      }

      return Right(uniqueCars.values.toList());
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, FilterInfo>> getFilterInfo() async {
    try {
      final response = await remoteDataSource.getFilterInfo();

      final filterInfo = FilterInfo(
        brands: response.brands
            .map(
              (brand) => Brand(
                id: brand.id,
                name: brand.attributes.name,
                logo: brand.attributes.logo,
              ),
            )
            .toList(),
        types: response.types.map((type) => CarType(name: type.name)).toList(),
        years: response.years,
        maxPrice: response.maxPrice,
        minPrice: response.minPrice,
      );

      return Right(filterInfo);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
