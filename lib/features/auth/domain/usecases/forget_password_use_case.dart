import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/auth/domain/entities/auth_response.dart';
import 'package:x_go/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<Either<ErrorModel, AuthResponse>> call({required String email}) async {
    return await repository.forgetPassword(email: email);
  }
}
