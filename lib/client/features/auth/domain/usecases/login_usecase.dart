import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/auth/data/models/login_response_model.dart';
import 'package:x_go/client/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<ErrorModel, LoginResponseModel>> call({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    return await repository.login(
      email: email,
      password: password,
      isRememberMe: isRememberMe,
    );
  }
}
