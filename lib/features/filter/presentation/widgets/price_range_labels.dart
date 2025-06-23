import 'package:flutter/material.dart';

class PriceRangeLabels extends StatelessWidget {
  const PriceRangeLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(),
            ),
            child: const Text("Minimum\n\$70", textAlign: TextAlign.center),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(),
            ),
            child: const Text("Maximum\n\$300", textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}

