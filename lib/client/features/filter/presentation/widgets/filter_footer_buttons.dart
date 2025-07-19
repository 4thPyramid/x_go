import 'package:flutter/material.dart';

class FilterFooterButtons extends StatelessWidget {
  final VoidCallback? onClearPressed;
  final VoidCallback? onApplyPressed;

  const FilterFooterButtons({
    super.key,
    this.onClearPressed,
    this.onApplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onClearPressed,
          child: const Text("Delete Filters"),
        ),
        ElevatedButton(
          onPressed: onApplyPressed,
          style: ElevatedButton.styleFrom(
            
            backgroundColor: const Color(0xffE6911E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text("Show Cars"),
        ),
      ],
    );
  }
}

