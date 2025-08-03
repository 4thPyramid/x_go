import 'package:x_go/delivery/features/orderDetails/data/models/change_stats_responce.dart';
import 'package:x_go/delivery/features/orderDetails/domain/repos/order_details_repo.dart';

class ChangeBookingStatus {
  final BookingDetailsRepository repository;

  ChangeBookingStatus(this.repository);

  Future<ChangeStatsResponse> call(int id, String status) {
    return repository.changeBookingStatus(id, status);
  }
}
