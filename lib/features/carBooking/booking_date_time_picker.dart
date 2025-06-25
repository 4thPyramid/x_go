import 'package:flutter/material.dart';

class BookingDateTimePicker extends StatelessWidget {
  final String label;
  final Widget? prefixIcon;
  const BookingDateTimePicker({required this.label, super.key, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon:prefixIcon,
        hintText: label,
        hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }
}
