part of 'my_booking_cubit.dart';

sealed class MyBookingState extends Equatable {
  const MyBookingState();

  @override
  List<Object> get props => [];
}

final class MyBookingInitial extends MyBookingState {}

final class MyBookingLoading extends MyBookingState {}

final class MyBookingLoaded extends MyBookingState {
  final List<MyBookingModel> bookings;

  const MyBookingLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class MyBookingError extends MyBookingState {
  final String message;

  const MyBookingError({required this.message});

  @override
  List<Object> get props => [message];
}
