import 'package:flutter/material.dart';

class BookingDateTimePicker extends StatelessWidget {
  final String label;
  final Widget? prefixIcon;
  final double? width;

  const BookingDateTimePicker({
    super.key,
    required this.label,
    this.prefixIcon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // يسمح بتمرير عرض مخصص
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: label,
          hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
      ),
    );
  }
}
