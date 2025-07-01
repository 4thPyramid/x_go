import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/carBooking/booking_date_time_picker.dart';

class BookingDateTimeSection extends StatelessWidget {
  final String label1;
  final String label2;

  const BookingDateTimeSection({
    required this.label1,
    required this.label2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BookingDateTimePicker(
          width: 150.w,
          label: label1,
          prefixIcon: const Icon(Icons.calendar_today),
        ),
        const SizedBox(width: 8),
        BookingDateTimePicker(
          width: 110.w,
          label: label2,
          prefixIcon: const Icon(Icons.access_time),
        ),
      ],
    );
  }
}
