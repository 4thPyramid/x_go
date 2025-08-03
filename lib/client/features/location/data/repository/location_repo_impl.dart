import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/location/data/data_source/location_data_source.dart';
import 'package:x_go/client/features/location/domain/repository/location_repo.dart';

class LocationRepoImpl implements LocationRepo {
  final LocationDataSourceImpl remoteDataSource;
  LocationRepoImpl(this.remoteDataSource);
  @override
  Future<Either<ErrorModel, void>> setLocation({
    required String latitude,
    required String longitude,
    required String location,
    required bool isActive,
  }) {
    return remoteDataSource.setLocation(
      latitude: latitude,
      longitude: longitude,
      location: location,
      isActive: isActive,
    );
  }
}
