import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/locatin_services_home.dart';
import 'location_state.dart';

class HomeDeliveryLocationCubit extends Cubit<LocationState> {
  final LocationHomeDeliveryService locationHomeDeliveryService;

  HomeDeliveryLocationCubit(this.locationHomeDeliveryService)
    : super(const LocationState.initial());

  Future<void> fetchLocation() async {
    emit(const LocationState.loading());
    try {
      final address = await locationHomeDeliveryService.getReadableLocation();
      if (address.isNotEmpty) {
        emit(LocationState.success(address));
      } else {
        emit(const LocationState.error('لم يتم العثور على عنوان'));
      }
    } catch (e) {
      emit(LocationState.error('تعذر جلب العنوان: ${e.toString()}'));
    }
  }

  void resetLocation() {
    emit(const LocationState.initial());
  }

  void clearError() {
    state.maybeWhen(
      error: (message) => emit(const LocationState.initial()),
      orElse: () {},
    );
  }
}
