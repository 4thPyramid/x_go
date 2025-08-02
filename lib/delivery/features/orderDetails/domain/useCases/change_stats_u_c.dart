import 'package:x_go/delivery/features/orderDetails/domain/repos/order_details_repo.dart';

class ChangeBookingStatus {
  final BookingDetailsRepository repository;

  ChangeBookingStatus(this.repository);

  Future<void> call(int id, String status) async {
    await repository.changeBookingStatus(id, status);
  }
}
