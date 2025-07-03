import 'package:dartz/dartz.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';

abstract class CarBookingRemoteDataSource {
  Future<Either<ErrorModel, void>> bookCar({
    required String carId,
    required String startDate,
    required String endDate,
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
  }) async {
    var response = await apiConsumer.post(
      '/Model/3/car-booking',
      data: {'car_id': carId, 'start_date': startDate, 'end_date': endDate},
    );
    return response;
  }
}
