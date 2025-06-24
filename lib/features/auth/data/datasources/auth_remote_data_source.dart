import 'package:x_go/core/data/api/api_consumer.dart';

import '../models/auth_response_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  });

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> otp({required String email, required String otp});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<AuthResponseModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      '/register',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'password': password,
      },
      isFormData: true,
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Lang': 'ar',
      },
    );

    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      '/login',
      data: {'email': email, 'password': password},
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    );
    // CacheHelper.saveToken(token: response.);
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> otp({
    required String email,
    required String otp,
  }) async {
    final response = await apiConsumer.post(
      '/verify-email',
      data: {'email': email, 'code': otp},
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    );
    return AuthResponseModel.fromJson(response);
  }
}
