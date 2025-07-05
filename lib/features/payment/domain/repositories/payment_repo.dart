import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';

abstract class PaymentRepo {
  Future<Either<ErrorModel, void>> setPayment(PaymentMethod paymentMethod);
}
