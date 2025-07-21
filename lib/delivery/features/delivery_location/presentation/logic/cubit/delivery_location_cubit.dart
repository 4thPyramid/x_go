import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/services/google_map_service.dart';
import 'package:firebase_database/firebase_database.dart';

part 'delivery_location_state.dart';

class DeliveryLocationCubit extends Cubit<DeliveryLocationState> {
  DeliveryLocationCubit() : super(DeliveryLocationInitial());

  late Set<Marker> markers;
  void getCurrentLocation() async {
    final permission = await LocationService().requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final currentPermission = await LocationService().checkPermission();

      if (currentPermission == LocationPermission.always ||
          currentPermission == LocationPermission.whileInUse) {
        try {
          final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          final latLng = LatLng(position.latitude, position.longitude);
          markers = {
            Marker(
              markerId: const MarkerId('current_location'),
              position: latLng,
              infoWindow: const InfoWindow(title: 'Current Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          };
          startStream(latLng);
          emit(
            CurrentLocationSuccess(currentPosition: latLng, markers: markers),
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
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(timeLimit: Duration(seconds: 5)),
    ).listen((position) {
      final latLng = LatLng(position.latitude, position.longitude);

      markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: latLng,
          infoWindow: const InfoWindow(title: 'Current Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };

      addToFirebase(latLng);

      emit(CurrentLocationSuccess(currentPosition: latLng, markers: markers));
    });
  }

  void addToFirebase(LatLng currentPosition) async {
    try {
      Timer.periodic(Duration(seconds: 5), (timer) async {
        await FirebaseDatabase.instance
            .ref('orders/order_abc123/location')
            .set({
              'latitude': currentPosition.latitude,
              'longitude': currentPosition.longitude,
            });
      });
      emit(
        CurrentLocationSuccess(
          currentPosition: currentPosition,
          markers: markers,
        ),
      );
    } catch (e) {
      emit(CurrentLocationError(errorMessage: e.toString()));
    }
  }
}
