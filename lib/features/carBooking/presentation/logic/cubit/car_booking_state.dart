part of 'car_booking_cubit.dart';

sealed class CarBookingState extends Equatable {
  const CarBookingState();

  @override
  List<Object> get props => [];
}

final class CarBookingInitial extends CarBookingState {}

final class SetLocationLoading extends CarBookingState {}

final class SetLocationSuccess extends CarBookingState {}

final class SetLocationError extends CarBookingState {
  final String message;
  const SetLocationError(this.message);
}

final class CarBookingLoading extends CarBookingState {}

final class CarBookingSuccess extends CarBookingState {}

final class CarBookingError extends CarBookingState {
  final String message;
  const CarBookingError(this.message);
}
