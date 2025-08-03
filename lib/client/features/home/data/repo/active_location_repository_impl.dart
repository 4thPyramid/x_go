import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/client/features/home/data/datasources/active_location_local_data_source.dart';
import 'package:x_go/client/features/home/data/models/location_active_hive_model.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/client/features/home/data/datasources/active_location_remote_data_source.dart';
import 'package:x_go/client/features/home/domain/entity/active_location.dart';
import 'package:x_go/client/features/home/domain/repo/active_location_repository.dart';

class ActiveLocationRepositoryImpl implements ActiveLocationRepository {
  final ActiveLocationRemoteDataSource remoteDataSource;
  final ActiveLocationLocalDataSource localDataSource;

  ActiveLocationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<ErrorModel, LocationActive>> getActiveLocation() async {
    try {
      final response = await remoteDataSource.getActiveLocation();

      final location = LocationActive(
        id: response.data.id,
        location: response.data.location,
        latitude: response.data.latitude,
        longitude: response.data.longitude,
        isActive: response.data.isActive,
      );

      // ✅ حفظ في الكاش المحلي
      final hiveModel = LocationActiveHiveModel.fromEntity(location);
      await localDataSource.cacheActiveLocation(hiveModel);

      return Right(location);
    } on DioException catch (e) {
      // ❌ فشل في الاتصال => ارجع من الكاش
      final cached = await localDataSource.getCachedActiveLocation();
      if (cached != null) {
        return Right(cached.toEntity());
      }
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      final cached = await localDataSource.getCachedActiveLocation();
      if (cached != null) {
        return Right(cached.toEntity());
      }
      return Left(e.errorModel);
    }
  }
}
