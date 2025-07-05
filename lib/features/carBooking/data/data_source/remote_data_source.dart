import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';

abstract class CarBookingRemoteDataSource {
  Future<Either<ErrorModel, void>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String lat,
    required String long,
    required String location,
  });
}

class CarBookingRemoteDataSourceImpl implements CarBookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  CarBookingRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<Either<ErrorModel, void>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String lat,
    required String long,
    required String location,
  }) async {
    try {
      var response = await apiConsumer.post(
        '/Model/3/car-booking',
        data: {
          'car_id': carId,
          'start_date': startDate,
          'end_date': endDate,
          'additional_driver': isAdditionalDriverChecked,
          'latitude': lat,
          'longitude': long,
          'location': location,
        },
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
