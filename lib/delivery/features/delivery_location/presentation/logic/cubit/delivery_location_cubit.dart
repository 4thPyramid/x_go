import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/services/google_map_service.dart';

part 'delivery_location_state.dart';

class DeliveryLocationCubit extends Cubit<DeliveryLocationState> {
  DeliveryLocationCubit() : super(DeliveryLocationInitial());

  late Marker marker;
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
          marker = Marker(
            markerId: const MarkerId('current_location'),
            position: latLng,
            infoWindow: const InfoWindow(title: 'Current Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          );

          emit(CurrentLocationSuccess(currentPosition: latLng, marker: marker));
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
}
