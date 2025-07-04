import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/core/services/google_map_service.dart';
import 'package:x_go/features/location/data/data_source/location_data_source.dart';
import 'package:x_go/features/location/data/repository/location_repo_impl.dart';
import 'package:x_go/features/location/domain/use_cases/set_location_use_case.dart';

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
          print(" Failed to get location: $e");
        }
      } else {
        print(" Location permission not granted.");
      }
    } else {
      print(" Location permission denied.");
    }
  }

  setLocation(String latitude, String longitude, String location) {
    final useCase = SetLocationUseCase(
      LocationRepoImpl(LocationDataSourceImpl(DioConsumer(dio: Dio()))),
    );
    emit(state.copyWith(isLoading: true));
    useCase
        .call(latitude: latitude, longitude: longitude, location: location)
        .then((value) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        })
        .catchError((error) {
          emit(
            state.copyWith(
              isLoading: false,
              isError: true,
              errorMessage: error.toString(),
            ),
          );
        });
  }
}
