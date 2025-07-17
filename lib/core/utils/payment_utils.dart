import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/features/payment/presentation/logic/cubit/payment_cubit.dart';
import 'package:x_go/features/payment/presentation/widgets/confirmation_dailog.dart';

class PaymentUtils {
  static void processPayment({
    required BuildContext context,
    required PaymentMethod method,
    required String finalPrice,
    required String modelId,
    required String bookingId,
  }) {
    final cubit = context.read<PaymentCubit>();
    
    cubit.setPaymentMethod(
      method,
      context,
      finalPrice,
      modelId,
      bookingId,
    );
  }

  static void handlePaymentState(BuildContext context, PaymentState state) {
    if (state is PaymentError) {
      showToast(message: state.message, state: ToastStates.ERROR);
    } else if (state is PaymentSuccess) {
      showConfirmationDialog(context);
    }
  }

  static void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ConfirmationDialog(),
    );
  }
}