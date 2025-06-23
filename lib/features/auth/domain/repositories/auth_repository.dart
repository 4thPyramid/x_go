import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import '../entities/auth_response.dart';
import '../entities/login_response.dart';

abstract class AuthRepository {
  Future<Either<ErrorModel, AuthResponse>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  });

  Future<Either<ErrorModel, LoginResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<ErrorModel, AuthResponse>> otp({
    required String email,
    required String otp,
  });
}
