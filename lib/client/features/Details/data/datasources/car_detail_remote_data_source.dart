// features/Details/data/datasources/car_detail_remote_data_source.dart
import 'dart:convert';

import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_model.dart';
import 'package:x_go/core/utils/app_loggr.dart';

abstract class CarDetailRemoteDataSource {
  Future<CarDetailResponse> getCarDetail(String id);
}

class CarDetailRemoteDataSourceImpl implements CarDetailRemoteDataSource {
  final ApiConsumer apiConsumer;

  CarDetailRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<CarDetailResponse> getCarDetail(String id) async {
    try {
      final response = await apiConsumer.get(
        '${EndpointsStrings.carDetail}/$id',
      );

      if (response is Map<String, dynamic>) {
        AppLogger.d('Received direct JSON response');

        try {
          // Check if data field exists
          if (!response.containsKey('data')) {
            AppLogger.w('Response does not contain "data" field');
            AppLogger.i('Response keys: ${response.keys.toList()}');
            throw Exception('Response does not contain required "data" field');
          }

          return CarDetailResponse.fromJson(response);
        } catch (e) {
          AppLogger.e('Error processing response data: $e');
          throw ServerException(
            errorModel: ErrorModel(
              message: 'Failed to process car details: $e',
            ),
          );
        }
      } else {
        AppLogger.i('API Response Status Code: ${response.statusCode}');

        if (response.statusCode == 200) {
          AppLogger.d('API Response: ${response.body}');

          try {
            if (response.body.isEmpty) {
              throw Exception('Empty response body');
            }

            final jsonData = json.decode(response.body);
            AppLogger.d('Decoded JSON type: ${jsonData.runtimeType}');

            if (jsonData is! Map<String, dynamic>) {
              throw Exception('Response is not a valid JSON object');
            }

            // Check if data field exists
            if (!jsonData.containsKey('data')) {
              AppLogger.w('Response does not contain "data" field');
              AppLogger.i('Response keys: ${jsonData.keys.toList()}');
              throw Exception(
                'Response does not contain required "data" field',
              );
            }

            return CarDetailResponse.fromJson(jsonData);
          } catch (e) {
            AppLogger.e('Error parsing JSON: $e');
            throw ServerException(
              errorModel: ErrorModel(
                message: 'Failed to parse car details: $e',
              ),
            );
          }
        } else {
          AppLogger.w('API Error Response: ${response.body}');
          throw ServerException(
            errorModel: ErrorModel(
              message:
                  'Failed to load car details: Status ${response.statusCode}',
            ),
          );
        }
      }
    } catch (e) {
      AppLogger.e('Exception in getCarDetail: $e');
      throw ServerException(
        errorModel: ErrorModel(message: 'Network or server error: $e'),
      );
    }
  }
}
