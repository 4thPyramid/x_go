import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:x_go/core/common/functions/clean_location_text.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/core/services/google_map_service.dart';
import 'package:x_go/client/features/location/data/data_source/location_data_source.dart';
import 'package:x_go/client/features/location/data/repository/location_repo_impl.dart';
import 'package:x_go/client/features/location/domain/use_cases/set_location_use_case.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit()
    : super(
        LocationState(
          currentPosition: const LatLng(30.99, 30.99),
          marker: const Marker(
            markerId: MarkerId('1'),
            position: LatLng(30.99, 30.99),
          ),
        ),
      );

  void changeMarkerPosition(LatLng position, GoogleMapController controller) {
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
    animateCamera(position, controller);
  }

  void animateCamera(LatLng position, GoogleMapController controller) {
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  Future<String> getLocationName(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) return 'Unknown location';

    final placemark = placemarks.first;

    // Remove numbers from each field
    String cleanStreet = cleanText(placemark.street.toString());
    print(cleanStreet);
    return '$cleanStreet';
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

  void setLocation(
    String latitude,
    String longitude,
    String location,
    bool isActive,
  ) {
    final useCase = SetLocationUseCase(
      LocationRepoImpl(LocationDataSourceImpl(DioConsumer(dio: Dio()))),
    );
    emit(state.copyWith(isLoading: true));
    useCase
        .call(
          latitude: latitude,
          longitude: longitude,
          location: location,
          isActive: isActive,
        )
        .then((value) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
        })
        .catchError((error, trace) {
          print("Error setting location: $error");
          print('Trace: $trace');
          emit(
            state.copyWith(
              isLoading: false,
              isError: true,
              errorMessage: trace.toString(),
            ),
          );
        });
  }
}
