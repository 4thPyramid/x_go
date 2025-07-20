import 'package:dartz/dartz.dart';

import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/auth/domain/entities/auth_response.dart';
import 'package:x_go/client/features/auth/domain/repositories/auth_repository.dart';

class OtpUseCase {
  final AuthRepository repository;

  OtpUseCase(this.repository);

  Future<Either<ErrorModel, AuthResponse>> call({
    required String email,
    required String otp,
  }) async {
    return await repository.otp(email: email, otp: otp);
  }
}
