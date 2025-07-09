import 'package:flutter/material.dart';

class PriceRangeLabels extends StatelessWidget {
  final RangeValues rangeValues;

  const PriceRangeLabels({super.key, required this.rangeValues});

  @override
  Widget build(BuildContext context) {
    final minPrice = rangeValues.start.round();
    final maxPrice = rangeValues.end.round();

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
            child: Text(
              "Minimum\n\$${minPrice.toString()}",
              textAlign: TextAlign.center,
            ),
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
            child: Text(
              "Maximum\n\$${maxPrice.toString()}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
