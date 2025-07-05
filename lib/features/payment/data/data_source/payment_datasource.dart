import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';

abstract class PaymentDataSource {
  Future<Either<ErrorModel, void>> setPayment(PaymentMethod paymentMethod);
}

class PaymentDataSourceImpl implements PaymentDataSource {
  @override
  Future<Either<ErrorModel, void>> setPayment(
    PaymentMethod paymentMethod,
  ) async {
    final apiConsumer = DioConsumer(dio: Dio());
    try {
      final response = await apiConsumer.post(
        '/Model/1/car-booking/6/payment-method',
        data: {
          'payment_method': paymentMethod == PaymentMethod.visa
              ? 'visa'
              : 'cash',
        },
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
