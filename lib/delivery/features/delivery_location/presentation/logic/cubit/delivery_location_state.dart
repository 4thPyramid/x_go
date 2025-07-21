part of 'delivery_location_cubit.dart';

sealed class DeliveryLocationState extends Equatable {
  const DeliveryLocationState();

  @override
  List<Object> get props => [];
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
  @override
  List<Object> get props => [currentPosition, markers];
}

final class CurrentLocationError extends DeliveryLocationState {
  final String errorMessage;

  const CurrentLocationError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
