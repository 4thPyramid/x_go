import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:x_go/core/services/payment_service.dart';
import 'package:x_go/features/payment/data/data_source/payment_datasource.dart';
import 'package:x_go/features/payment/data/repositories/payment_repo_impl.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/features/payment/domain/repositories/payment_repo.dart';
import 'package:x_go/features/payment/domain/use_cases/set_payment_use_case.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> setPaymentMethod(
    PaymentMethod paymentMethod,
    BuildContext context,
  ) async {
    emit(PaymentLoading());
    try {
      final useCase = SetPaymentUseCase(
        PaymentRepoImpl(paymentDataSource: PaymentDataSourceImpl()),
      );
      final result = await useCase.call(paymentMethod);
      result.fold((l) => emit(PaymentError(l.message)), (r) {
        emit(PaymentSuccess());
        pay(paymentMethod, context);
      });
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> pay(PaymentMethod paymentMethod, BuildContext context) async {
    if (paymentMethod == PaymentMethod.visa) {
      await paymoobServise(context);
    } else if (paymentMethod == PaymentMethod.cash) {}
  }

  Future<void> paymoobServise(BuildContext context) async {
    final authToken = await PaymobService.getAuthToken();
    final orderId = await PaymobService.createOrder(
      authToken,
      int.parse('100') * 100,
    );
    final paymentKey = await PaymobService.getPaymentKey(
      authToken,
      orderId,
      int.parse('100') * 100,
    );
    String paymentUrl =
        "https://accept.paymob.com/api/acceptance/iframes/905872?payment_token=$paymentKey";
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymobPaymentScreen(iframeUrl: paymentUrl),
      ),
    );
  }
}
