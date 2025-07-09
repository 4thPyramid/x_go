import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/features/home/data/datasources/car_remote_datasource_impl.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CarEntity>>> getCars(
    HomeRequestParams params,
  ) async {
    try {
      final response = await remoteDataSource.getCars(params);

      final cars = response.data
          .map((carModel) => carModel.toEntity())
          .toList();

      return Right(cars);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, FilterInfo>> getFilterInfo() async {
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
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.message));
    }
  }
}
