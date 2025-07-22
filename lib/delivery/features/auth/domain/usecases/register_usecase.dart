import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/auth/domain/entities/auth_response.dart';
import 'package:x_go/delivery/features/auth/domain/repositories/auth_repository.dart';

class DeliveryRegisterUseCase {
  final DeliveryAuthRepository repository;

  DeliveryRegisterUseCase(this.repository);

  Future<Either<ErrorModel, AuthResponse>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    return await repository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
