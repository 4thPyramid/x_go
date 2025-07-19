import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/payment/domain/entites/payment_method.dart';

abstract class PaymentRepo {
  Future<Either<ErrorModel, void>> setPaymentMethod(
    PaymentMethod paymentMethod,
    String modelId,
    String bookingId,
  );
}
