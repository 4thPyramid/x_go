import 'package:flutter/material.dart';

class PriceRangeLabels extends StatelessWidget {
  final RangeValues rangeValues;

  const PriceRangeLabels({super.key, required this.rangeValues});

  @override
  Widget build(BuildContext context) {
    final minPrice = (rangeValues.start * 100).toInt(); // مثال: تحويل 4 => 40
    final maxPrice = (rangeValues.end * 100).toInt();

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
            child: Text("Minimum\n\$$minPrice", textAlign: TextAlign.center),
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
            child: Text("Maximum\n\$$maxPrice", textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}
