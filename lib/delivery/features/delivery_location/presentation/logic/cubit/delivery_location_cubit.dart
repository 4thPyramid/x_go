import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/core/services/google_map_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:x_go/delivery/features/delivery_location/data/data_source/remote_data_source.dart';
import 'package:x_go/delivery/features/delivery_location/data/repositories/delivery_location_repo_impl.dart';
import 'package:x_go/delivery/features/delivery_location/domain/use_cases/get_best_route_uc.dart';
import 'package:x_go/delivery/features/delivery_location/domain/use_cases/refuse_order_uc.dart';

part 'delivery_location_state.dart';

class DeliveryLocationCubit extends Cubit<DeliveryLocationState> {
  DeliveryLocationCubit() : super(DeliveryLocationInitial());
  StreamSubscription<Position>? positionStreamSubscription;

  late Set<Marker> markers;
  late List<LatLng> polylines = [];
  String duration = '';
  String distance = '';
  late LatLng destination;

  String hash = '';
  void getCurrentLocation() async {
    final permission = await LocationService().requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final currentPermission = await LocationService().checkPermission();

      if (currentPermission == LocationPermission.always ||
          currentPermission == LocationPermission.whileInUse) {
        try {
          final position = await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 10,
            ),
          );
          final latLng = LatLng(position.latitude, position.longitude);
          markers = {
            Marker(
              markerId: const MarkerId('current_location'),
              position: latLng,
              infoWindow: const InfoWindow(title: 'Current Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
            ),
          };

          startStream(latLng);
          emit(
            CurrentLocationSuccess(
              currentPosition: latLng,
              markers: markers,
              polylines: polylines,
              duration: duration,
              distance: distance,
            ),
          );
        } catch (e) {
          emit(CurrentLocationError(errorMessage: e.toString()));
        }
      } else {
        emit(
          CurrentLocationError(
            errorMessage: 'Location permission not granted.',
          ),
        );
      }
    } else {
      emit(CurrentLocationError(errorMessage: 'Location permission denied.'));
    }
  }

  void startStream(LatLng currentPosition) {
    positionStreamSubscription?.cancel();
    try {
      positionStreamSubscription =
          Geolocator.getPositionStream(
            locationSettings: LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 10,
            ),
          ).listen((position) async {
            final latLng = LatLng(position.latitude, position.longitude);

            markers = {
              Marker(
                markerId: const MarkerId('current_location'),
                position: latLng,
                infoWindow: const InfoWindow(title: 'Current Location'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue,
                ),
              ),
            };
            emit(
              CurrentLocationSuccess(
                currentPosition: latLng,
                markers: markers,
                polylines: polylines,
                duration: duration,
                distance: distance,
              ),
            );

            await getCode(latLng, destination);
            addToFirebase(latLng, hash);
          });
    } on Exception catch (e) {
      print('Error starting position stream: ${e.toString()}');
      emit(CurrentLocationError(errorMessage: e.toString()));
    }
  }

  void addToFirebase(LatLng currentPosition, String hashCode) async {
    try {
      await FirebaseDatabase.instance.ref('orders/order_abc123/location').set({
        'latitude': currentPosition.latitude,
        'longitude': currentPosition.longitude,
        'polyline': hashCode,
      });
    } catch (e) {
      emit(CurrentLocationError(errorMessage: e.toString()));
    }
  }

  List<LatLng> decodePolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints(
      apiKey: 'AIzaSyBRvxQVv7DEX_lklJnEDS4kTB7ehgXG8lU',
    );
    List<PointLatLng> result = PolylinePoints.decodePolyline(encodedPolyline);
    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(result.last.latitude, result.last.longitude),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    return result.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }

  Future<void> getCode(LatLng currentPosition, LatLng destination) async {
    try {
      final useCase = GetBestRouteUc(
        DeliveryLocationRepoImpl(RemoteDataSourceImpl(DioConsumer(dio: Dio()))),
      );

      final result = await useCase.call(currentPosition, destination);

      result.fold(
        (failure) {
          emit(DeliveryLocationError(errorMessage: failure.message));
        },
        (routeData) {
          // Debug logs

          // Decode polyline
          polylines = decodePolyline(routeData.polyline ?? '');
          hash = routeData.polyline;

          // Parse distance string into kilometers
          final distanceKm = _parseDistanceToKm(routeData.distance);

          if (distanceKm < 0.5) {
            emit(SuccessArrived());
          } else {
            emit(
              CurrentLocationSuccess(
                currentPosition: currentPosition,
                markers: markers,
                polylines: polylines,
                duration: routeData.duration,
                distance: routeData.distance,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(DeliveryLocationError(errorMessage: 'حدث خطأ غير متوقع'));
    }
  }

  /// Helper method to parse distance string and return value in kilometers
  double _parseDistanceToKm(String? distanceStr) {
    if (distanceStr == null) return 0.0;

    final cleaned = distanceStr.toLowerCase().trim();

    final match = RegExp(r'(\d+(\.\d+)?)').firstMatch(cleaned);
    if (match == null) return 0.0;

    final value = double.tryParse(match.group(0) ?? '0') ?? 0.0;

    if (cleaned.contains('km')) {
      return value;
    } else if (cleaned.contains('m')) {
      return value / 1000.0;
    }

    return 0.0;
  }

  void refuseOrder(String bookingId) async {
    try {
      emit(RefuseOrderLoading());
      final useCase = RefuseOrderUc(
        DeliveryLocationRepoImpl(RemoteDataSourceImpl(DioConsumer(dio: Dio()))),
      );

      final result = await useCase.call(bookingId);

      result.fold(
        (failure) {
          emit(RefuseOrderError(errorMessage: failure.message));
        },
        (routeData) {
          emit(RefuseOrderSuccess());
        },
      );
    } catch (e) {
      emit(RefuseOrderError(errorMessage: e.toString()));
    }
  }
}
