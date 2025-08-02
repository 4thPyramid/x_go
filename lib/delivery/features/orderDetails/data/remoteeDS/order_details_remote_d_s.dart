// lib/features/booking/data/datasources/booking_remote_data_source.dart
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/delivery/features/orderDetails/data/models/change_stats_responce.dart';

import '../models/booking_model.dart';

abstract class BookingDetailsRemoteDataSource {
  Future<BookingModel> getBookingDetails(int id);
  Future<ChangeStatsResponse> changeBookingStatus(int id, String status);
}

class BookingDetailsRemoteDataSourceImpl implements BookingDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingDetailsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<BookingModel> getBookingDetails(int id) async {
    final response = await apiConsumer.get(
      '/api/driver/booking/$id',

    );
    return BookingModel.fromJson(response['data']);
  }
  @override
  Future<ChangeStatsResponse> changeBookingStatus(int id, String status) async {
    final response = await apiConsumer.post(
      '/api/driver/booking/$id/status',
      data: {
        'status': status,
      },
    );
    return ChangeStatsResponse(
      message: response['message'],
      data: StatsModel.fromJson(response['data']),
    );
  }
}
