import 'package:dartz/dartz.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';

abstract class LocationDataSource {
  Future<Either<ErrorModel, void>> setLocation({
    required String latitude,
    required String longitude,
    required String location,
  });
}

class LocationDataSourceImpl implements LocationDataSource {
  final ApiConsumer apiConsumer;

  LocationDataSourceImpl(this.apiConsumer);

  @override
  Future<Either<ErrorModel, void>> setLocation({
    required String latitude,
    required String longitude,
    required String location,
  }) async {
    var response = await apiConsumer.post(
      '/user-location',
      data: {
        'latitude': latitude,
        'longitude': longitude,
        'location': location,
      },
    );
    return response;
  }
}
