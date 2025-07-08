import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/features/payment/domain/repositories/payment_repo.dart';

class SetPaymentUseCase {
  final PaymentRepo paymentRepo;

  SetPaymentUseCase(this.paymentRepo);

  Future<Either<ErrorModel, void>> call(
    PaymentMethod paymentMethod,
    String modelId,
    String bookingId,
  ) {
    return paymentRepo.setPaymentMethod(paymentMethod, modelId, bookingId);
  }
}
