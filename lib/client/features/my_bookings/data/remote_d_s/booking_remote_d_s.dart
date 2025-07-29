import 'package:dio/dio.dart';
import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/client/features/my_bookings/data/models/booking_model.dart';

class BookingRemoteDataSource {
  final ApiConsumer apiConsumer;

  BookingRemoteDataSource(this.apiConsumer);

  Future<List<MyBookingModel>> getBookingList() async {
    try {
      final response = await apiConsumer.get(EndpointsStrings.bookingList);

      // التأكد من صحة البيانات
      if (response['data'] is List) {
        final List<dynamic> data = response['data'];
        return data.map((json) => MyBookingModel.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw Exception('Failed to load booking list');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }
}
