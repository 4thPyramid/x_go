import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';

class BookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingRemoteDataSource(this.apiConsumer);

  Future<List<BookingModel>> getBookingList() async {
    try {
      final response = await apiConsumer.get('booking-list');
      final List<dynamic> data = response['data'];

      return data
          .map((json) {
            try {
              return BookingModel.fromJson(json as Map<String, dynamic>);
            } catch (e) {
              print('❌ Failed to parse booking item: $e');
              return null;
            }
          })
          .whereType<BookingModel>()
          .toList();
        } catch (e) {
      print('❌ Error getting booking list: $e');
      rethrow;
    }
  }
}
