import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/delivery/features/orderDetails/data/models/change_stats_responce.dart';
import 'package:x_go/delivery/features/orderDetails/domain/useCases/change_stats_u_c.dart';
import 'package:x_go/delivery/features/orderDetails/domain/useCases/order_details_u_c.dart';
import '../../domain/entities/booking_entity.dart';

part 'booking_state.dart';

class BookingDetailsCubit extends Cubit<BookingState> {
  final GetBookingDetailsUseCase getBookingDetails;
  final ChangeBookingStatus changeBookingStatus;

  BookingDetailsCubit(this.getBookingDetails, this.changeBookingStatus)
    : super(BookingInitial());

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

  void changebookingStatus(int id, String status) async {
    emit(BookingLoading());
    try {
      final response = await changeBookingStatus.call(id, status);
      emit(BookingStatusChanged(response));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
