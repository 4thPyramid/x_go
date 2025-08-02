import 'package:dio/dio.dart';
import 'error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handelDioException(DioException e) {
  // Helper function to safely create ErrorModel
  ErrorModel _createErrorModel(DioException exception) {
    if (exception.response?.data != null && exception.response?.data is Map<String, dynamic>) {
      return ErrorModel.fromJson(exception.response!.data);
    } else {
      return ErrorModel(message: exception.message ?? 'Network error occurred');
    }
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errorModel: _createErrorModel(e));
    case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: _createErrorModel(e));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorModel: _createErrorModel(e));
    case DioExceptionType.cancel:
      throw ServerException(errorModel: _createErrorModel(e));
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: _createErrorModel(e));
    case DioExceptionType.connectionError:
      throw ServerException(errorModel: _createErrorModel(e));
    case DioExceptionType.unknown:
      throw ServerException(errorModel: _createErrorModel(e));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 408:
        case 500:
        case 502:
        case 503:
        default:
          throw ServerException(errorModel: _createErrorModel(e));
      }
  }
}
