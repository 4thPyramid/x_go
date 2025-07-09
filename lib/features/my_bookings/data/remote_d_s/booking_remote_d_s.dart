import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';

class BookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingRemoteDataSource(this.apiConsumer);

  Future<List<BookingModel>> getBookingList() async {
    final response = await apiConsumer.get('booking-list');
    final List<dynamic> data = response['data'] ?? [];

    return data
        .map((json) => BookingModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
