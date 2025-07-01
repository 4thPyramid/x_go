import 'package:flutter/material.dart';

class FilterFooterButtons extends StatelessWidget {
  final void Function()? onPressed;
  const FilterFooterButtons({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: onPressed, child: const Text("Clear All")),
        ElevatedButton(
          onPressed: () {},
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
