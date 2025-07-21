part of 'delivery_location_cubit.dart';

sealed class DeliveryLocationState {
  const DeliveryLocationState();
}

final class DeliveryLocationInitial extends DeliveryLocationState {}

final class CurrentLocationLoading extends DeliveryLocationState {}

final class CurrentLocationSuccess extends DeliveryLocationState {
  final LatLng currentPosition;
  final Set<Marker> markers;

  const CurrentLocationSuccess({
    required this.currentPosition,
    required this.markers,
  });
}

final class CurrentLocationError extends DeliveryLocationState {
  final String errorMessage;

  const CurrentLocationError({required this.errorMessage});
}
