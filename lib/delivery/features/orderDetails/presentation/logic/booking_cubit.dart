// lib/features/booking/presentation/cubit/booking_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/delivery/features/orderDetails/domain/useCases/order_details_u_c.dart';
import '../../domain/entities/booking_entity.dart';

part 'booking_state.dart';

class BookingDetailsCubit extends Cubit<BookingState> {
  final GetBookingDetailsUseCase getBookingDetails;

   BookingDetailsCubit(this.getBookingDetails) : super(BookingInitial());

  void fetchBookingDetails(int id) async {
    emit(BookingLoading());
    try {
      final booking = await getBookingDetails(id);
      emit(BookingLoaded(booking));
    } catch (e) {
      print('Error fetching booking details: $e');
      emit(BookingError(e.toString()));
      print('Error fetching booking details: $e');
    }
  }
}
