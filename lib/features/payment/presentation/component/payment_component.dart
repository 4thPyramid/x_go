import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/services/payment_service.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/features/payment/presentation/widgets/confirmation_dailog.dart';
import 'package:x_go/features/payment/presentation/widgets/payment_option_tile.dart';

class PaymentComponent extends StatefulWidget {
  const PaymentComponent({super.key});

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
            label: '**** **** **** 8395',
            selectedMethod: _selectedMethod,
            onSelected: (value) => setState(() => _selectedMethod = value),
          ),
          PaymentOptionTile(
            method: PaymentMethod.apple,
            icon: const Icon(Icons.apple, color: Colors.black),
            label: '**** **** **** 4395',
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
          CustomButton(
            text: 'Submit',
            onPressed: () async {
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
                  builder: (context) =>
                      PaymobPaymentScreen(iframeUrl: paymentUrl),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
