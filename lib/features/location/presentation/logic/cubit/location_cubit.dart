import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:x_go/core/services/google_map_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit()
    : super(
        LocationState(
          currentPosition: const LatLng(30.0, 30.0),
          marker: const Marker(
            markerId: MarkerId('1'),
            position: LatLng(31.8978, 31.2987),
          ),
        ),
      );

  void changeMarkerPosition(LatLng position) {
    final newMarker = state.marker.copyWith(positionParam: position);
    getLocationName(position).then((value) {
      emit(
        state.copyWith(
          currentPosition: position,
          marker: newMarker,
          locationName: value,
        ),
      );
    });
  }

  Future<String> getLocationName(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return '${placemarks.first.name} ${placemarks.first.street}';
  }

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
          final locationName = await getLocationName(latLng);

          emit(
            state.copyWith(
              currentPosition: latLng,
              locationName: locationName,
              marker: state.marker.copyWith(positionParam: latLng),
            ),
          );
        } catch (e) {
          print("❌ Failed to get location: $e");
        }
      } else {
        print("❌ Location permission not granted.");
      }
    } else {
      print("❌ Location permission denied.");
    }
  }
}
