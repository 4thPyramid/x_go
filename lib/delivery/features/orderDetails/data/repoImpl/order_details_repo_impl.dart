// lib/features/booking/data/repositories/booking_repository_impl.dart
import 'package:x_go/delivery/features/orderDetails/data/models/booking_model.dart';
import 'package:x_go/delivery/features/orderDetails/data/models/change_stats_responce.dart';
import 'package:x_go/delivery/features/orderDetails/data/remoteeDS/order_details_remote_d_s.dart';
import 'package:x_go/delivery/features/orderDetails/domain/repos/order_details_repo.dart';

import '../../domain/entities/booking_entity.dart';

class BookingDetailsRepositoryImpl implements BookingDetailsRepository {
  final BookingDetailsRemoteDataSource remoteDataSource;

  BookingDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<BookingEntity> getBookingDetails(int id) async {
    final model = await remoteDataSource.getBookingDetails(id);
    return model.toEntity();
  }

  @override
  Future<ChangeStatsResponse> changeBookingStatus(int id, String status) async {
    return await remoteDataSource.changeBookingStatus(id, status);
  }
}
