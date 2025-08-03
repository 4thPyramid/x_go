import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/delivery_location/data/model/route_model.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<Either<ErrorModel, RouteModel>> getBestRoute(
    LatLng currentPosition,
    LatLng destination,
  );

  Future<Either<ErrorModel, dynamic>> refuseOrder(String bookingId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiConsumer apiConsumer;
  RemoteDataSourceImpl(this.apiConsumer);
  @override
  Future<Either<ErrorModel, RouteModel>> getBestRoute(
    LatLng currentPosition,
    LatLng destination,
  ) async {
    try {
      final response = await apiConsumer.post(
        EndpointsStrings.getBestRoute,
        queryParameters: {
          'origin': '${currentPosition.latitude},${currentPosition.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
        },
      );

      final data = RouteModel.fromJson(response);
      return Right(data);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, dynamic>> refuseOrder(String bookingId) async {
    try {
      var response = await apiConsumer.post(
        '/api/driver/booking/$bookingId/status',
        data: {'status': 'canceled'},
      );
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
