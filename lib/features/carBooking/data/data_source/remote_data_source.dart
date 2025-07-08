import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/carBooking/data/model/locations_model.dart';

abstract class CarBookingRemoteDataSource {
  Future<Either<ErrorModel, BookingModel>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String locationId,
  });
  Future<Either<ErrorModel, LocationsModel>> getLocations();
}

class CarBookingRemoteDataSourceImpl implements CarBookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  CarBookingRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<Either<ErrorModel, BookingModel>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
    required String isAdditionalDriverChecked,
    required String locationId,
  }) async {
    try {
      final locationData = isAdditionalDriverChecked == '1'
          ? {'location_id': locationId}
          : {};
      var response = await apiConsumer.post(
        '/Model/3/car-booking',
        data: {
          'car_id': carId,
          'start_date': startDate,
          'end_date': endDate,
          'additional_driver': isAdditionalDriverChecked,
          ...locationData,
        },
      );
      final data = BookingModel.fromJson(response);
      return Right(data);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, LocationsModel>> getLocations() async {
    try {
      var response = await apiConsumer.get('user-locations');
      final data = LocationsModel.fromJson(response);
      return Right(data);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
