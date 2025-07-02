import 'package:flutter/material.dart';

class FilterFooterButtons extends StatelessWidget {
  final void Function()? onPressed;
  final void Function()? onApply;

  const FilterFooterButtons({super.key, this.onPressed, this.onApply});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: onPressed, child: const Text("Clear All")),
        ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(
            
            backgroundColor: const Color(0xffE6911E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text("Show less"),
        )
      ],
    );
  }
}
