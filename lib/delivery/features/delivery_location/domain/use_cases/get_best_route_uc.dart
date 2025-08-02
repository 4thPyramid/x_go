import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/delivery_location/data/model/route_model.dart';
import 'package:x_go/delivery/features/delivery_location/domain/repositories/driver_location_repo.dart';

class GetBestRouteUc {
  final DriverLocationRepo driverLocationRepository;

  GetBestRouteUc(this.driverLocationRepository);

  Future<Either<ErrorModel, RouteModel>> call(
    LatLng currentPosition,
    LatLng destination,
  ) async {
    return await driverLocationRepository.getBestRoute(
      currentPosition,
      destination,
    );
  }
}
