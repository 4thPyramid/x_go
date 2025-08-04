// features/Details/data/repo/car_detail_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:x_go/client/features/Details/data/datasources/car_detail_local_data_source.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_hive_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/client/features/Details/data/datasources/car_detail_remote_data_source.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_model.dart';
import 'package:x_go/client/features/Details/domain/repo/car_detail_repository.dart';

class CarDetailRepositoryImpl implements CarDetailRepository {
  final CarDetailRemoteDataSource remoteDataSource;
  final CarDetailLocalDataSource localDataSource;
  CarDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CarDetailResponse>> getCarDetail(String id) async {
    try {
      final result = await remoteDataSource.getCarDetail(id);
      // Cache the result locally
      final model = result.data;
      final cacheModel = CarDetailHiveModel(
        modelName: model.relationship.modelName.name,
        type: model.relationship.type.name,
        brand: model.relationship.brand.name,
        averageRating: model.relationship.ratings.averageRating,
        ratingsCount: model.relationship.ratings.ratingsCount,
        year: model.attributes.year,
        price: model.attributes.price,
        engineType: model.attributes.engineType,
        transmissionType: model.attributes.transmissionType,
        seatType: model.attributes.seatType,
        seatsCount: model.attributes.seatsCount,
        acceleration: model.attributes.acceleration,
        image: model.attributes.image,
      );
      await localDataSource.cacheCarDetail(id, cacheModel);
      return Right(result);
    } on ServerException catch (e) {
      // Try to return cached data if available
      final cached = await localDataSource.getCachedCarDetail(id);
      if (cached != null) {
        final fallback = CarDetailResponse(
          data: CarDetailModel(
            id: id,
            attributes: CarDetailAttributes(
              year: cached.year,
              price: cached.price,
              engineType: cached.engineType,
              transmissionType: cached.transmissionType,
              seatType: cached.seatType,
              seatsCount: cached.seatsCount,
              acceleration: cached.acceleration,
              image: cached.image,
            ),
            relationship: CarDetailRelationship(
              modelName: ModelName(id: '', name: cached.modelName),
              type: CarType(id: '', name: cached.type),
              brand: Brand(id: 0, name: cached.brand),
              ratings: Ratings(
                averageRating: cached.averageRating,
                ratingsCount: cached.ratingsCount,
                reviews: [],
              ),
              images: [],
            ),
          ),
        );

        return Right(fallback);
      }

      return Left(ServerFailure(e.errorModel.message));
    }
  }
}
