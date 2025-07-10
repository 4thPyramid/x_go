// features/location/data/repositories/location_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/features/home/data/datasources/active_location_remote_data_source.dart';
import 'package:x_go/features/home/domain/entity/active_location.dart';
import 'package:x_go/features/home/domain/repo/active_location_repository.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';

class ActiveLocationRepositoryImpl implements ActiveLocationRepository {
  final ActiveLocationRemoteDataSource remoteDataSource;

  ActiveLocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LocationActive>> getActiveLocation() async {
    try {
      final response = await remoteDataSource.getActiveLocation();

      final location = LocationActive(
        id: response.data.id,
        location: response.data.location,
        latitude: response.data.latitude,
        longitude: response.data.longitude,
        isActive: response.data.isActive,
      );

      return Right(location);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.message));
    }
  }
}
