part of 'car_booking_cubit.dart';

sealed class CarBookingState extends Equatable {
  const CarBookingState();

  @override
  List<Object> get props => [];
}

final class CarBookingInitial extends CarBookingState {}

final class CarBookingLoading extends CarBookingState {}

final class CarBookingSuccess extends CarBookingState {
  final BookingModel model;
  const CarBookingSuccess(this.model);
}

final class CarBookingError extends CarBookingState {
  final String message;
  const CarBookingError(this.message);
}

final class GetLocationLoading extends CarBookingState {}

final class GetLocationSuccess extends CarBookingState {
  final LocationsModel locations;
  const GetLocationSuccess(this.locations);
}

final class GetLocationError extends CarBookingState {
  final String message;
  const GetLocationError(this.message);
}
