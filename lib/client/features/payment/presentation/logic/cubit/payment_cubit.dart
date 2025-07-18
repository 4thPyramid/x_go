import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/core/services/payment_service.dart';
import 'package:x_go/client/features/payment/data/data_source/payment_datasource.dart';
import 'package:x_go/client/features/payment/data/repositories/payment_repo_impl.dart';
import 'package:x_go/client/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/client/features/payment/domain/use_cases/set_payment_use_case.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> setPaymentMethod(
    PaymentMethod paymentMethod,
    BuildContext context,
    final_price,
    String modelId,
    String bookingId,
  ) async {
    emit(PaymentLoading());
    try {
      final useCase = SetPaymentUseCase(
        PaymentRepoImpl(paymentDataSource: PaymentDataSourceImpl()),
      );
      final result = await useCase.call(paymentMethod, modelId, bookingId);
      result.fold((l) => emit(PaymentError(l.message)), (r) {
        emit(PaymentSuccess());
        pay(paymentMethod, context, final_price, modelId, bookingId);
      });
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  static String? model_id;
  static String? booking_id;
  Future<void> pay(
    PaymentMethod paymentMethod,
    BuildContext context,
    final_price,
    String modelId,
    String bookingId,
  ) async {
    model_id = modelId;
    booking_id = bookingId;

    if (paymentMethod == PaymentMethod.visa) {
      await paymoobServise(context, final_price);
    } else if (paymentMethod == PaymentMethod.cash) {}
  }

  Future<void> paymoobServise(BuildContext context, final_price) async {
    final authToken = await PaymobService.getAuthToken();
      final priceInCents = (double.parse(final_price.toString()) * 100).toInt();

    final orderId = await PaymobService.createOrder(
      authToken,
      priceInCents,
    );
    final paymentKey = await PaymobService.getPaymentKey(
      authToken,
      orderId,
      priceInCents,
    );
    String paymentUrl =
        "https://accept.paymob.com/api/acceptance/iframes/905872?payment_token=$paymentKey";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymobPaymentScreen(iframeUrl: paymentUrl),
      ),
    );
  }

  paymentInfo(String paymentStatus, String transactionId) async {
    emit(PaymentLoading());
    final apiConsumer = DioConsumer(dio: Dio());
    try {
      final response = await apiConsumer.post(
        '/Model/$model_id/car-booking/$booking_id/paymob-info',
        data: {
          'payment_status': paymentStatus,
          'transaction_id': transactionId,
        },
      );
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
