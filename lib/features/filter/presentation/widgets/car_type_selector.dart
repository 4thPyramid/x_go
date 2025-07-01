import 'package:flutter/material.dart';

class FuelTypeSelector extends StatelessWidget {
  const FuelTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('car Type', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            FilterChip(label: const Text("Any"), selected: true, onSelected: (_) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text("Manual"), selected: false, onSelected: (_) {}),
            const SizedBox(width: 10),
            FilterChip(label: const Text("Automatic"), selected: false, onSelected: (_) {}),
          ],
        ),
      ],
    );
  }
}