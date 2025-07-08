// features/home/data/datasources/home_remote_data_source.dart
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/features/home/data/models/Pagination_response_odel%20.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';

abstract class HomeRemoteDataSource {
  Future<CarsPaginationResponse> getCars(HomeRequestParams params);
  Future<FilterInfoResponse> getFilterInfo();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeRemoteDataSourceImpl({required this.apiConsumer});

  @override
// HomeRemoteDataSource - مبسط بدون duplicate checking
  @override
  Future<CarsPaginationResponse> getCars(HomeRequestParams params) async {
    print('🌐 === API REQUEST ===');
    print('Search term: "${params.search ?? 'none'}"');

    final requestData = params.toMap();
    print('📤 Request data: $requestData');

    final response = await apiConsumer.post(
      ApiEndPoints.home,
      data: requestData,
    );
    final responseMap = Map<String, dynamic>.from(response);

    print('📥 Backend response: ${responseMap['data']?.length ?? 0} cars');

    // تطبيق فلترة محلية للبحث إذا لزم الأمر
    if (params.search?.isNotEmpty == true) {
      final originalData = responseMap['data'] as List;
      final searchTerm = params.search!.toLowerCase().trim();

      print('🔍 Checking backend search accuracy for: "$searchTerm"');

      // تحقق من دقة نتائج البحث من الـ backend
      bool needsClientFiltering = false;
      for (var item in originalData) {
        final car = Map<String, dynamic>.from(item);
        final attributes = Map<String, dynamic>.from(car['attributes']);
        final relationship = Map<String, dynamic>.from(car['relationship']);
        final brand = Map<String, dynamic>.from(relationship['Brand']);
        final types = Map<String, dynamic>.from(relationship['Types']);

        final name = attributes['name'].toString().toLowerCase();
        final brandName = brand['brand_name'].toString().toLowerCase();
        final typeName = types['type_name'].toString().toLowerCase();
        final engineType = attributes['engine_type'].toString().toLowerCase();
        final transmissionType = attributes['transmission_type'].toString().toLowerCase();
        final seatType = attributes['seat_type'].toString().toLowerCase();

        final matches = name.contains(searchTerm) ||
            brandName.contains(searchTerm) ||
            typeName.contains(searchTerm) ||
            engineType.contains(searchTerm) ||
            transmissionType.contains(searchTerm) ||
            seatType.contains(searchTerm);

        if (!matches) {
          needsClientFiltering = true;
          break;
        }
      }

      if (needsClientFiltering) {
        print('⚙️ Applying client-side filtering...');

        final filteredData = originalData.where((item) {
          final car = Map<String, dynamic>.from(item);
          final attributes = Map<String, dynamic>.from(car['attributes']);
          final relationship = Map<String, dynamic>.from(car['relationship']);
          final brand = Map<String, dynamic>.from(relationship['Brand']);
          final types = Map<String, dynamic>.from(relationship['Types']);

          final name = attributes['name'].toString().toLowerCase();
          final brandName = brand['brand_name'].toString().toLowerCase();
          final typeName = types['type_name'].toString().toLowerCase();
          final engineType = attributes['engine_type'].toString().toLowerCase();
          final transmissionType = attributes['transmission_type'].toString().toLowerCase();
          final seatType = attributes['seat_type'].toString().toLowerCase();

          final matches = name.contains(searchTerm) ||
              brandName.contains(searchTerm) ||
              typeName.contains(searchTerm) ||
              engineType.contains(searchTerm) ||
              transmissionType.contains(searchTerm) ||
              seatType.contains(searchTerm);

          if (matches) {
            print('✅ Match: ${attributes['name']} (${brand['brand_name']})');
          }

          return matches;
        }).toList();

        print('🎯 Client-side filtered results: ${filteredData.length} cars');

        responseMap['data'] = filteredData;
        responseMap['meta'] = <String, dynamic>{
          ...Map<String, dynamic>.from(responseMap['meta']),
          'total': filteredData.length,
          'current_page': 1,
          'last_page': 1,
          'from': filteredData.isNotEmpty ? 1 : 0,
          'to': filteredData.length,
        };
      } else {
        print('✅ Backend search working correctly!');
      }
    }

    return CarsPaginationResponse.fromJson(responseMap);
  }

  @override
  Future<FilterInfoResponse> getFilterInfo() async {
    try {
      print('📋 Fetching filter info...');
      final response = await apiConsumer.get(ApiEndPoints.filterInfo);
      print('✅ Filter info loaded successfully');
      return FilterInfoResponse.fromJson(response);
    } catch (e) {
      print('❌ Filter info error: $e');
      rethrow;
    }
  }
}

class ApiEndPoints {
  static const String baseUrl = 'https://xgo.ibrahimbashaa.com/api/user/';
  static const String home = 'Home';
  static const String filterInfo = 'filter-Info';
}
