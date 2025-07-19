import 'package:flutter/material.dart';

class AdditionalDriverCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?) onChanged;

  const AdditionalDriverCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const Text('Additional Driver'),
      ],
    );
  }
}