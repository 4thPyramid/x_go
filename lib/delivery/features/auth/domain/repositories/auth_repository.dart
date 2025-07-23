import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/auth/data/models/login_response_model.dart';
import 'package:x_go/delivery/features/auth/domain/entities/auth_response.dart';
abstract class DeliveryAuthRepository {
  Future<Either<ErrorModel, AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  });

  Future<Either<ErrorModel, DriverModel>> login({
    required String email,
    required String password,
    required bool isRememberMe,
  });

  Future<Either<ErrorModel, AuthResponse>> forgetPassword({
    required String email,
  });

  Future<Either<ErrorModel, AuthResponse>> otp({
    required String email,
    required String otp,
  });

  Future<Either<ErrorModel, AuthResponse>> resetPassword({
    required String email,
    required String password,
    required String otp,
  });
}
