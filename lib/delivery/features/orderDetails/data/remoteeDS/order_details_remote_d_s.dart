// lib/features/booking/data/datasources/booking_remote_data_source.dart
import 'package:x_go/core/data/api/api_consumer.dart';
import '../models/booking_model.dart';

abstract class BookingDetailsRemoteDataSource {
  Future<BookingModel> getBookingDetails(int id);
}

class BookingDetailsRemoteDataSourceImpl implements BookingDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingDetailsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<BookingModel> getBookingDetails(int id) async {
    final response = await apiConsumer.get(
      '/api/driver/booking/$id',

    );
    return BookingModel.fromJson(response.data['data']);
  }
}
