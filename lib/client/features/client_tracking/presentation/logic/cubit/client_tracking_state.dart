part of 'client_tracking_cubit.dart';

abstract class ClientTrackingState {}

class InitialClientTrackingState extends ClientTrackingState {}

class ClientTrackingLoading extends ClientTrackingState {}

class ClientTrackingSuccess extends ClientTrackingState {
  final LatLng latLng;
  final Set<Marker> markers;
  final String hash;
  final Set<Polyline> polylines;
  ClientTrackingSuccess({
    required this.hash,
    required this.latLng,
    required this.markers,
    required this.polylines,
  });
}

class ClientTrackingError extends ClientTrackingState {
  final String errorMessage;
  ClientTrackingError({required this.errorMessage});
}
