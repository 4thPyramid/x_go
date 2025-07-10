import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';

class BookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingRemoteDataSource(this.apiConsumer);

  Future<List<MyBookingModel>> getBookingList() async {
    try {
      final response = await apiConsumer.get('booking-list');
      final List<dynamic> data = response['data'];

      return data.map((json) => MyBookingModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load booking list');
    }
  }
}
