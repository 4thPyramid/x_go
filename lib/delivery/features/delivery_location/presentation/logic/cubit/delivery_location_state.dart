part of 'delivery_location_cubit.dart';

sealed class DeliveryLocationState {
  const DeliveryLocationState();
}

final class DeliveryLocationInitial extends DeliveryLocationState {}

final class CurrentLocationLoading extends DeliveryLocationState {}

final class CurrentLocationSuccess extends DeliveryLocationState {
  final LatLng currentPosition;
  final Set<Marker> markers;
  final List<LatLng> polylines;
  final String duration;
  final String distance;

  const CurrentLocationSuccess({
    required this.currentPosition,
    required this.markers,
    required this.polylines,
    required this.duration,
    required this.distance,
  });
  @override
  List<Object> get props => [currentPosition, markers, polylines];
}

final class CurrentLocationError extends DeliveryLocationState {
  final String errorMessage;

  const CurrentLocationError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class DeliveryLocationError extends DeliveryLocationState {
  final String errorMessage;

  const DeliveryLocationError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class SuccessArrived extends DeliveryLocationState {}
