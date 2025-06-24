import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/auth/domain/entities/auth_response.dart';
import 'package:x_go/features/auth/domain/entities/login_response.dart';
import 'package:x_go/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<ErrorModel, AuthResponse>> call({
    required String email,
    required String password,
  }) async {
    return await repository.resetPassword(email: email, password: password);
  }
}
