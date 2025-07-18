import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/auth/data/models/login_response_model.dart';
import '../entities/auth_response.dart';

abstract class AuthRepository {
  Future<Either<ErrorModel, AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  });

  Future<Either<ErrorModel, LoginResponseModel>> login({
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
