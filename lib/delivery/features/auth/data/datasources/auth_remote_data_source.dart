import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/delivery/features/auth/data/models/auth_response_model.dart';
import 'package:x_go/delivery/features/auth/data/models/login_response_model.dart';

abstract class DeliveryAuthRemoteDataSource {
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

class DeliveryAuthRemoteDataSourceImpl implements DeliveryAuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  DeliveryAuthRemoteDataSourceImpl({required this.apiConsumer});

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
    // ياقرش  ابقى اعمل موديل جديد لليدريفر ف اللوجين والريجيستر  لان كل حاجه متغيره وسيب
    CacheHelper.driverId(value: response['user']['id'].toString());

    return AuthResponseModel.fromJson(response);
  }

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    final response = await apiConsumer.post(
      EndpointsStrings.loginDelivery,
      data: {'email': email, 'password': password},
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
      },
    );

    CacheHelper.saveToken(value: response['token']);
    CacheHelper.driverId(value: response['user']['id'].toString());
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
