import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';

abstract class LocationDataSource {
  Future<Either<ErrorModel, void>> setLocation({
    required String latitude,
    required String longitude,
    required String location,
    required bool isActive,
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
    required bool isActive,
  }) async {
    try {
      print("Location: $location");
      print("Latitude: $latitude");
      print("Longitude: $longitude");
      print("Is Active: $isActive");
      var response = await apiConsumer.post(
        '/user-locations',
        data: {
          'latitude': latitude,
          'longitude': longitude,
          'location': location,
          'is_active': isActive ? '1' : '0',
        },
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    }
  }
}
