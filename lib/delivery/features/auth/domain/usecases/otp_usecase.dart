import 'package:dartz/dartz.dart';

import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/auth/domain/entities/auth_response.dart';
import 'package:x_go/delivery/features/auth/domain/repositories/auth_repository.dart';

class DeliveryOtpUseCase {
  final DeliveryAuthRepository repository;

  DeliveryOtpUseCase(this.repository);

  Future<Either<ErrorModel, AuthResponse>> call({
    required String email,
    required String otp,
  }) async {
    return await repository.otp(email: email, otp: otp);
  }
}
