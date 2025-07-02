import 'package:flutter/material.dart';

class FuelTypeSelector extends StatelessWidget {
  final String? selectedFuelType;
  final ValueChanged<String> onFuelTypeSelected;

  const FuelTypeSelector({
    super.key,
    required this.selectedFuelType,
    required this.onFuelTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final fuelTypes = ['suv', 'Manual', 'Automatic'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Car Type', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: fuelTypes.map((type) {
            final isSelected = selectedFuelType == type;
            return FilterChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (_) => onFuelTypeSelected(type),
              selectedColor: Colors.orange.shade200,
              checkmarkColor: Colors.black,
            );
          }).toList(),
        ),
      ],
    );
  }
}
