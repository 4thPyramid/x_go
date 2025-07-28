import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/constants/endpoints_strings.dart';
import '../../errors/exceptions.dart';
import '../cached/cache_helper.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndpointsStrings.baseUrl;
    dio.interceptors
        .clear(); // مهم جدًا علشان تمسح أي Interceptors مضافة قبل كده

    dio.interceptors.add(
      AwesomeDioInterceptor(
        logRequestTimeout: true,
        logRequestHeaders: true,
        logResponseHeaders: true,
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
      final token = CacheHelper.getToken();
      final lang = CacheHelper.getData(key: 'languageKey') ?? 'en';
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'application/vnd.api+json',
            'accept-language': lang,
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer h6eEI4TjdryL7eYp0cCMFp3FtLx1ZqX6ULyonIOw33cba209',
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
      final token = CacheHelper.getToken();
      final lang = CacheHelper.getData(key: 'languageKey') ?? 'en';

      final response = await dio.post(
        path,
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'accept-language': lang,

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
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
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
        data: isFormData
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
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
