import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/auth/domain/entities/auth_response.dart';
import 'package:x_go/client/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<ErrorModel, AuthResponse>> call({
    required String email,
    required String password,
    required String otp,
  }) async {
    return await repository.resetPassword(
      email: email,
      password: password,
      otp: otp,
    );
  }
}
