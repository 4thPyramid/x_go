import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:x_go/client/features/home/domain/entity/active_location.dart';
import 'package:x_go/core/services/google_map_service.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/client/features/home/domain/usecase/get_active_location_usecase.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/active_location/active_location_state.dart';

class ActiveLocationCubit extends Cubit<ActiveLocationState> {
  final GetActiveLocationUseCase getActiveLocationUseCase;
  final LocationService locationService; // ✅ injected service

  ActiveLocationCubit({
    required this.getActiveLocationUseCase,
    required this.locationService,
  }) : super(ActiveLocationInitial());

  Future<void> getActiveLocation() async {
    if (isClosed) return;

    emit(ActiveLocationLoading());

    final result = await getActiveLocationUseCase(NoParams());

    if (isClosed) return;

    await result.fold(
      (failure) async {
        // بدل ما تعرض الخطأ، حاول تجيب الموقع من GPS
        await _emitCurrentLocationFromGPS(fallbackError: failure.message);
      },
      (location) async {
        if (isClosed) return;

        if (location.location.isEmpty) {
          await _emitCurrentLocationFromGPS();
        } else {
          emit(ActiveLocationLoaded(activeLocation: location));
        }
      },
    );
  }

  Future<void> _emitCurrentLocationFromGPS({String? fallbackError}) async {
    try {
      final position = await locationService.getCurrentPosition();

      if (position == null || isClosed) {
        if (fallbackError != null && !isClosed) {
          emit(ActiveLocationError(message: fallbackError));
        }
        return;
      }

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (isClosed) return;

      final placemark = placemarks.first;
      final locationName =
          '${placemark.administrativeArea ?? ''}, ${placemark.subAdministrativeArea ?? ''}, ${placemark.locality ?? ''}';

      emit(
        ActiveLocationLoaded(
          activeLocation: LocationActive(
            id: 0,
            location: locationName,
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            isActive: true,
          ),
        ),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        ActiveLocationError(
          message: fallbackError ?? 'فشل في الحصول على الموقع الحالي',
        ),
      );
    }
  }
}
