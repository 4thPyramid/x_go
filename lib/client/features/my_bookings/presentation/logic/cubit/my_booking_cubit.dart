import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:x_go/client/features/my_bookings/data/models/booking_model.dart';
import 'package:x_go/client/features/my_bookings/domain/usecases/get_booking_use_case.dart';

part 'my_booking_state.dart';

class MyBookingCubit extends Cubit<MyBookingState> {
  final GetBookingList getBookingListUseCase;

  MyBookingCubit(this.getBookingListUseCase) : super(MyBookingInitial());

  Future<void> getBookingList() async {
    emit(MyBookingLoading());

    final result = await getBookingListUseCase.call();

    result.fold(
      (error) => emit(MyBookingError(message: error.message)),
      (bookings) => emit(MyBookingLoaded(bookings: bookings)),
    );
  }
}
