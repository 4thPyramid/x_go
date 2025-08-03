import 'package:x_go/delivery/features/orderDetails/data/models/change_stats_responce.dart';
import 'package:x_go/delivery/features/orderDetails/domain/entities/booking_entity.dart';

abstract class BookingDetailsRepository {
  Future<BookingEntity> getBookingDetails(int id);
  Future<ChangeStatsResponse> changeBookingStatus(int id, String status);
}
