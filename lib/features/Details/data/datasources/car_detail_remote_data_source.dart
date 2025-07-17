// features/Details/data/datasources/car_detail_remote_data_source.dart
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/features/Details/data/models/car_detail_model.dart';

abstract class CarDetailRemoteDataSource {
  Future<CarDetailResponse> getCarDetail(String id);
}

class CarDetailRemoteDataSourceImpl implements CarDetailRemoteDataSource {
  final ApiConsumer apiConsumer;
  final Logger _logger = Logger('CarDetailRemoteDataSource');

  CarDetailRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<CarDetailResponse> getCarDetail(String id) async {
    try {
      _logger.info('Fetching car details for ID: $id');
      final response = await apiConsumer.get(
        '${EndpointsStrings.carDetail}/$id',
      );

      // Handle different response types - the error suggests we might be
      // getting a Map directly instead of a response object with statusCode
      if (response is Map<String, dynamic>) {
        _logger.info('Received direct JSON response');

        try {
          // Check if data field exists
          if (!response.containsKey('data')) {
            _logger.warning('Response does not contain "data" field');
            _logger.info('Response keys: ${response.keys.toList()}');
            throw Exception('Response does not contain required "data" field');
          }

          return CarDetailResponse.fromJson(response);
        } catch (e) {
          _logger.severe('Error processing response data: $e');
          throw ServerException(
            errorModel: ErrorModel(
              message: 'Failed to process car details: $e',
            ),
          );
        }
      } else {
        _logger.info('API Response Status Code: ${response.statusCode}');

        if (response.statusCode == 200) {
          _logger.fine('API Response: ${response.body}');

          try {
            if (response.body.isEmpty) {
              throw Exception('Empty response body');
            }

            final jsonData = json.decode(response.body);
            _logger.fine('Decoded JSON type: ${jsonData.runtimeType}');

            if (jsonData is! Map<String, dynamic>) {
              throw Exception('Response is not a valid JSON object');
            }

            // Check if data field exists
            if (!jsonData.containsKey('data')) {
              _logger.warning('Response does not contain "data" field');
              _logger.info('Response keys: ${jsonData.keys.toList()}');
              throw Exception(
                'Response does not contain required "data" field',
              );
            }

            return CarDetailResponse.fromJson(jsonData);
          } catch (e) {
            _logger.severe('Error parsing JSON: $e');
            throw ServerException(
              errorModel: ErrorModel(
                message: 'Failed to parse car details: $e',
              ),
            );
          }
        } else {
          _logger.warning('API Error Response: ${response.body}');
          throw ServerException(
            errorModel: ErrorModel(
              message:
                  'Failed to load car details: Status ${response.statusCode}',
            ),
          );
        }
      }
    } catch (e) {
      _logger.severe('Exception in getCarDetail: $e');
      throw ServerException(
        errorModel: ErrorModel(message: 'Network or server error: $e'),
      );
    }
  }
}
