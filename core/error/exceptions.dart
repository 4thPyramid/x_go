class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException(String message, {int? statusCode}) 
    : super(message, statusCode: statusCode);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class CacheException extends AppException {
  CacheException(String message) : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message) : super(message);
}

class ValidationException extends AppException {
  final Map<String, dynamic> errors;

  ValidationException(String message, this.errors) : super(message);
}
