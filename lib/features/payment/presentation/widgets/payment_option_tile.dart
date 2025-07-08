import 'package:flutter/material.dart';
import 'package:x_go/features/payment/domain/entites/payment_method.dart';

class PaymentOptionTile extends StatelessWidget {
  final PaymentMethod method;
  final Icon icon;
  final String label;
  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onSelected;

  const PaymentOptionTile({
    super.key,
    required this.method,
    required this.icon,
    required this.label,
    required this.selectedMethod,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedMethod == method;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.orange : Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Radio<PaymentMethod>(
            value: method,
            groupValue: selectedMethod,
            onChanged: (value) => onSelected(value!),
            activeColor: Colors.orange,
          ),
          icon,
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }
}