// lib/features/booking/presentation/cubit/booking_state.dart
part of 'booking_cubit.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final BookingEntity booking;

  BookingLoaded(this.booking);
}

class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}
class BookingStatusChanged extends BookingState {
  final ChangeStatsResponse response;

  BookingStatusChanged(this.response);
}
 