import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/delivery_location/data/model/route_model.dart';

abstract class DriverLocationRepo {
  Future<Either<ErrorModel, RouteModel>> getBestRoute(
    LatLng currentPosition,
    LatLng destination,
  );
}
