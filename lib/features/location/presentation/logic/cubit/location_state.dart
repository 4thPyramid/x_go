part of 'location_cubit.dart';

class LocationState extends Equatable {
  final LatLng? currentPosition;
  final String? locationName;
  final bool isLoading;
  final String? errorMessage;
  final Marker marker;

  const LocationState({
    this.currentPosition,
    this.locationName,
    this.isLoading = false,
    this.errorMessage,
    Marker? marker,
  }) : marker =
           marker ??
           const Marker(markerId: MarkerId('1'), position: LatLng(0, 0));

  LocationState copyWith({
    LatLng? currentPosition,
    String? locationName,
    bool? isLoading,
    String? errorMessage,
    Marker? marker,
  }) {
    return LocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      locationName: locationName ?? this.locationName,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      marker: marker ?? this.marker,
    );
  }

  @override
  List<Object> get props => [
    currentPosition ?? const LatLng(0, 0),
    locationName ?? 'حدد العنوان',
    isLoading,
    errorMessage ?? '',
    marker,
  ];
}
