import 'package:dio/dio.dart';
import '../../constants/endpoints_strings.dart';
import '../../errors/exceptions.dart';
import '../cached/cache_helper.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndpointsStrings.baseUrl;
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      //final token = CacheHelper.getToken();
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization':
                'Bearer 41|6KKerhEqQTsvQfZYMkGSULqXNQx5tgdyVeplmkd7c5c741f1',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      // final token = CacheHelper.getToken();
      final response = await dio.post(
        path,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization':
                'Bearer 41|6KKerhEqQTsvQfZYMkGSULqXNQx5tgdyVeplmkd7c5c741f1',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final token = CacheHelper.getToken();
      final response = await dio.patch(
        path,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    final token = CacheHelper.getToken();
    final response = await dio.put(
      path,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final token = CacheHelper.getToken();
      final response = await dio.delete(
        path,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handelDioException(e);
    }
  }
}
