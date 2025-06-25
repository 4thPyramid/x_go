import 'package:flutter/material.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';
import 'package:x_go/features/payment/presentation/widgets/confirmation_dailog.dart';
import 'package:x_go/features/payment/presentation/widgets/payment_option_tile.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.visa;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ConfirmationDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Icon(Icons.directions_car, size: 80, color: Colors.grey.shade600),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text('Lamborghini Revuelto', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trip Dates'),
                                Text('21 Dec - 22 Dec'),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Pickup & Return'),
                                Text('Same location'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('\$2400', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
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
                      const Spacer(),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _showConfirmationDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// === widgets/payment_option_tile.dart ===



// === widgets/confirmation_dialog.dart ===

