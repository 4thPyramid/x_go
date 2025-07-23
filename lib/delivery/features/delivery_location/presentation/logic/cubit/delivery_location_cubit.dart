import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/core/services/google_map_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:x_go/delivery/features/delivery_location/data/data_source/remote_data_source.dart';
import 'package:x_go/delivery/features/delivery_location/data/repositories/delivery_location_repo_impl.dart';
import 'package:x_go/delivery/features/delivery_location/domain/use_cases/get_best_route_uc.dart';

part 'delivery_location_state.dart';

class DeliveryLocationCubit extends Cubit<DeliveryLocationState> {
  DeliveryLocationCubit() : super(DeliveryLocationInitial());
  StreamSubscription<Position>? _positionStreamSubscription;

  late Set<Marker> markers;
  late List<LatLng> polylines = [];
  String duration = '';
  String distance = '';
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
    _positionStreamSubscription?.cancel();
    try {
      _positionStreamSubscription =
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
            print(
              '0000000000000000000000000000000000000000000000000000000000000000000000000',
            );
            await getCode(latLng);
            addToFirebase(latLng);
          });
    } on Exception catch (e) {
      print('Error starting position stream: ${e.toString()}');
      emit(CurrentLocationError(errorMessage: e.toString()));
    }
  }

  void addToFirebase(LatLng currentPosition) async {
    try {
      await FirebaseDatabase.instance.ref('orders/order_abc123/location').set({
        'latitude': currentPosition.latitude,
        'longitude': currentPosition.longitude,
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

  Future<void> getCode(LatLng currentPosition) async {
    try {
      final useCase = GetBestRouteUc(
        DeliveryLocationRepoImpl(RemoteDataSourceImpl(DioConsumer(dio: Dio()))),
      );
      final result = await useCase.call(
        currentPosition,
        LatLng(30.034047, 31.876756),
      );
      print(result.toString());
      result.fold((l) => emit(DeliveryLocationError(errorMessage: l.message)), (
        r,
      ) {
        polylines = decodePolyline(r.polyline!);
        print('=999999999999999999999999999999=');
        print(polylines);
        print(r.duration);
        print(r.distance);
        double value =
            double.tryParse(
              RegExp(r'\d+(\.\d+)?').stringMatch(r.distance) ?? '0',
            ) ??
            0.0;

        if (value < 1) {
          emit(SuccessArrived());
        } else {
          emit(
            CurrentLocationSuccess(
              currentPosition: currentPosition,
              markers: markers,
              polylines: polylines,
              duration: r.duration!,
              distance: r.distance!,
            ),
          );
        }
      });
    } catch (e) {
      print('Error getting code: $e');

      emit(DeliveryLocationError(errorMessage: e.toString()));
    }
  }
}
