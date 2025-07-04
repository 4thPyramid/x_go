import 'package:flutter/material.dart';

class CarTypeSelector extends StatelessWidget {
  final List<String> types;
  final String? selectedType;
  final ValueChanged<String> onTypeSelected;

  const CarTypeSelector({
    super.key,
    required this.types,
    this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('نوع السيارة', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: types.map((type) {
            final isSelected = selectedType == type;
            return FilterChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (_) => onTypeSelected(type),
              selectedColor: Colors.orange.withOpacity(0.3),
              checkmarkColor: Colors.orange,
            );
          }).toList(),
        ),
      ],
    );
  }
}
