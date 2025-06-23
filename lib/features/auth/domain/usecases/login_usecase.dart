import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/auth/domain/entities/login_response.dart';
import 'package:x_go/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<ErrorModel, LoginResponse>> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
