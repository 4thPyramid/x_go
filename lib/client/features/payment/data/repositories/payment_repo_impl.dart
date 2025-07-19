import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/payment/data/data_source/payment_datasource.dart';
import 'package:x_go/client/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/client/features/payment/domain/repositories/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentDataSource paymentDataSource;

  PaymentRepoImpl({required this.paymentDataSource});

  @override
  Future<Either<ErrorModel, void>> setPaymentMethod(
    PaymentMethod paymentMethod,
    String modelId,
    String bookingId,
  ) async {
    return await paymentDataSource.setPaymentMethod(
      paymentMethod,
      modelId,
      bookingId,
    );
  }
}
