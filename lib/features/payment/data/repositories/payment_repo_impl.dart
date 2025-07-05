import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/payment/data/data_source/payment_datasource.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/features/payment/domain/repositories/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentDataSource paymentDataSource;

  PaymentRepoImpl({required this.paymentDataSource});

  @override
  Future<Either<ErrorModel, void>> setPayment(
    PaymentMethod paymentMethod,
  ) async {
    return await paymentDataSource.setPayment(paymentMethod);
  }
}
