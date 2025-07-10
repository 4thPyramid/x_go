import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';

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
    required bool isRememberMe,
  });

  Future<AuthResponseModel> forgetPassword({required String email});

  Future<AuthResponseModel> otp({required String email, required String otp});

  Future<AuthResponseModel> resetPassword({
    required String email,
    required String password,
    required String otp,
  });
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
      EndpointsStrings.register,
      data: {
        'name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'phone': phone,
      },
      isFormData: true,
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Lang': 'ar',
      },
    );
    CacheHelper.saveToken(value: response['token']);

    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    final response = await apiConsumer.post(
      EndpointsStrings.login,
      data: {'email': email, 'password': password},
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    );

    CacheHelper.saveToken(value: response['token']);
    isRememberMe
        ? CacheHelper.saveData(key: 'isRememberMe', value: true)
        : null;
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> forgetPassword({required String email}) async {
    final response = await apiConsumer.post(
      EndpointsStrings.forgetPassword,
      data: {'email': email},
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> otp({
    required String email,
    required String otp,
  }) async {
    final response = await apiConsumer.post(
      EndpointsStrings.verifyCode,
      data: {'email': email, 'code': otp},
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    );
    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<AuthResponseModel> resetPassword({
    required String email,
    required String password,
    required String otp,
  }) async {
    final response = await apiConsumer.post(
      EndpointsStrings.resetPassword,
      data: {
        'email': email,
        'password': password,
        'password_confirmation': password,
        'token': otp,
      },
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    );
    return AuthResponseModel.fromJson(response);
  }
}
