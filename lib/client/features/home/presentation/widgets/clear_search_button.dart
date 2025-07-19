import 'package:flutter/material.dart';

class ClearSearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearSearchButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.clear, color: Colors.grey),
      onPressed: onPressed,
      tooltip: 'Clear search',
    );
  }
}
