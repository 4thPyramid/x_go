import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'car_booking_state.dart';

class CarBookingCubit extends Cubit<CarBookingState> {
  CarBookingCubit() : super(CarBookingInitial());
  increment() {
    emit(
      (state as CounterState).copyWith(
        count: (state as CounterState).count + 1,
        isLoading: false,
      ),
    );
  }
}
