import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/delivery_location/data/data_source/remote_data_source.dart';
import 'package:x_go/delivery/features/delivery_location/data/model/route_model.dart';
import 'package:x_go/delivery/features/delivery_location/domain/repositories/driver_location_repo.dart';

class DeliveryLocationRepoImpl implements DriverLocationRepo {
  final RemoteDataSource remoteDataSource;
  DeliveryLocationRepoImpl(this.remoteDataSource);
  @override
  Future<Either<ErrorModel, RouteModel>> getBestRoute(
    LatLng currentPosition,
    LatLng destination,
  ) {
    return remoteDataSource.getBestRoute(currentPosition, destination);
  }

  @override
  Future<Either<ErrorModel, void>> refuseOrder(String bookingId) {
    return remoteDataSource.refuseOrder(bookingId);
  }
}
