import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/client/features/home/data/models/Pagination_response_odel%20.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';

/// Abstract interface for home remote data operations
abstract class HomeRemoteDataSource {
  Future<CarsPaginationResponse> getCars(HomeRequestParams params);
  Future<FilterInfoResponse> getFilterInfo();
}

/// Implementation of [HomeRemoteDataSource] that handles API calls and data filtering
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  const HomeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CarsPaginationResponse> getCars(HomeRequestParams params) async {
    final requestData = params.toMap();

    final response = await apiConsumer.post(
      EndpointsStrings.home,
      data: requestData,
    );

    final responseMap = Map<String, dynamic>.from(response);
    _applyClientSideFiltering(params, responseMap);

    return CarsPaginationResponse.fromJson(responseMap);
  }

  @override
  Future<FilterInfoResponse> getFilterInfo() async {
    final response = await apiConsumer.get(EndpointsStrings.filterInfo);
    return FilterInfoResponse.fromJson(response);
  }

  /// Applies client-side search filtering if needed
  void _applyClientSideFiltering(
    HomeRequestParams params,
    Map<String, dynamic> responseMap,
  ) {
    final searchTerm = params.search?.toLowerCase().trim();
    if (searchTerm == null || searchTerm.isEmpty) return;

    final originalData = responseMap['data'] as List;

    // Check if backend results need additional client-side filtering
    if (_needsClientSideFiltering(originalData, searchTerm)) {
      final filteredData = _filterCarsBySearchTerm(originalData, searchTerm);
      _updateResponseWithFilteredData(responseMap, filteredData);
    }
  }

  /// Checks if any cars in the data don't match the search term
  bool _needsClientSideFiltering(List originalData, String searchTerm) {
    return originalData.any(
      (item) => !_doesCarMatchSearchTerm(item, searchTerm),
    );
  }

  /// Filters cars based on search term matching
  List _filterCarsBySearchTerm(List originalData, String searchTerm) {
    return originalData.where((item) {
      final matches = _doesCarMatchSearchTerm(item, searchTerm);

      if (matches) {
        final carData = _extractCarData(item);
        print('✅ Match: ${carData.name} (${carData.brandName})');
      }

      return matches;
    }).toList();
  }

  /// Checks if a car matches the search term across multiple fields
  bool _doesCarMatchSearchTerm(dynamic item, String searchTerm) {
    final carData = _extractCarData(item);

    return carData.name.contains(searchTerm) ||
        carData.brandName.contains(searchTerm) ||
        carData.typeName.contains(searchTerm) ||
        carData.engineType.contains(searchTerm) ||
        carData.transmissionType.contains(searchTerm) ||
        carData.seatType.contains(searchTerm);
  }

  /// Extracts and normalizes car data from API response
  _CarData _extractCarData(dynamic item) {
    final car = Map<String, dynamic>.from(item);
    final attributes = Map<String, dynamic>.from(car['attributes']);
    final relationship = Map<String, dynamic>.from(car['relationship']);
    final brand = Map<String, dynamic>.from(relationship['Brand']);
    final types = Map<String, dynamic>.from(relationship['Types']);

    return _CarData(
      name: attributes['name'].toString().toLowerCase(),
      brandName: brand['brand_name'].toString().toLowerCase(),
      typeName: types['type_name'].toString().toLowerCase(),
      engineType: attributes['engine_type'].toString().toLowerCase(),
      transmissionType: attributes['transmission_type']
          .toString()
          .toLowerCase(),
      seatType: attributes['seat_type'].toString().toLowerCase(),
    );
  }

  /// Updates response map with filtered data and updated metadata
  void _updateResponseWithFilteredData(
    Map<String, dynamic> responseMap,
    List filteredData,
  ) {
    responseMap['data'] = filteredData;
    responseMap['meta'] = {
      ...Map<String, dynamic>.from(responseMap['meta']),
      'total': filteredData.length,
      'current_page': 1,
      'last_page': 1,
      'from': filteredData.isNotEmpty ? 1 : 0,
      'to': filteredData.length,
    };
  }
}

/// Helper class to hold normalized car data for search operations
class _CarData {
  final String name;
  final String brandName;
  final String typeName;
  final String engineType;
  final String transmissionType;
  final String seatType;

  const _CarData({
    required this.name,
    required this.brandName,
    required this.typeName,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
  });
}
