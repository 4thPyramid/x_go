import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';

abstract class PaymentDataSource {
  Future<Either<ErrorModel, void>> setPaymentMethod(
    PaymentMethod paymentMethod,
    String modelId,
    String bookingId,
  );
}

class PaymentDataSourceImpl implements PaymentDataSource {
  @override
  Future<Either<ErrorModel, void>> setPaymentMethod(
    PaymentMethod paymentMethod,
    String modelId,
    String bookingId,
  ) async {
    final apiConsumer = DioConsumer(dio: Dio());
    try {
      final response = await apiConsumer.post(
        '/Model/$modelId/car-booking/$bookingId/payment-method',
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
