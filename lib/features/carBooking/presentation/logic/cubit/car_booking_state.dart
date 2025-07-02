part of 'car_booking_cubit.dart';

sealed class CarBookingState extends Equatable {
  const CarBookingState();

  @override
  List<Object> get props => [];
}

final class CarBookingInitial extends CarBookingState {}

class CounterState extends CarBookingState {
  final int count;
  final bool isLoading;

  const CounterState(this.count, this.isLoading);
  CounterState copyWith({int? count, bool? isLoading}) {
    return CounterState(count ?? this.count, isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [count];
}
