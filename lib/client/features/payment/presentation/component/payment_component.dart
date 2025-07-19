import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/client/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/client/features/payment/presentation/logic/cubit/payment_cubit.dart';
import 'package:x_go/client/features/payment/presentation/widgets/confirmation_dailog.dart';
import 'package:x_go/client/features/payment/presentation/widgets/payment_option_tile.dart';

class PaymentComponent extends StatefulWidget {
  final String finalPrice;
  final String modelId;
  final String bookingId;
  const PaymentComponent({
    super.key,
    required this.finalPrice,
    required this.modelId,
    required this.bookingId,
  });

  @override
  State<PaymentComponent> createState() => _PaymentComponentState();
}

class _PaymentComponentState extends State<PaymentComponent> {
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ConfirmationDialog(),
    );
  }

  PaymentMethod _selectedMethod = PaymentMethod.visa;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          PaymentOptionTile(
            method: PaymentMethod.visa,
            icon: const Icon(Icons.credit_card, color: Colors.blue),
            label: 'Visa',
            selectedMethod: _selectedMethod,
            onSelected: (value) => setState(() => _selectedMethod = value),
          ),
          PaymentOptionTile(
            method: PaymentMethod.cash,
            icon: const Icon(Icons.money, color: Colors.green),
            label: 'Cash',
            selectedMethod: _selectedMethod,
            onSelected: (value) => setState(() => _selectedMethod = value),
          ),
          BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentError) {
                showToast(message: state.message, state: ToastStates.ERROR);
              } else if (state is PaymentSuccess) {
                _selectedMethod == PaymentMethod.visa
                    ? showToast(
                        message: 'wait for pay',
                        state: ToastStates.WARNING,
                      )
                    : _showConfirmationDialog(context);
              }
            },
            builder: (context, state) {
              return state is PaymentLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                      text: 'Submit',
                      onPressed: () async {
                        context.read<PaymentCubit>().setPaymentMethod(
                          _selectedMethod,
                          context,
                          widget.finalPrice,
                          widget.modelId,
                          widget.bookingId,
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}