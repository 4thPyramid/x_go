// filter_container.dart
import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  final Widget child;

  const FilterContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 252, 251, 251),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: child,
        ),
      ),
    );
  }
}
