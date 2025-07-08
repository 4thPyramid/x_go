import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDateTimeSection extends StatefulWidget {
  final String label1;
  final String label2;
  final void Function(DateTime?) onDateSelected;
  final void Function(TimeOfDay?) onTimeSelected;

  const BookingDateTimeSection({
    required this.label1,
    required this.label2,
    required this.onDateSelected,
    required this.onTimeSelected,
    super.key,
  });

  @override
  State<BookingDateTimeSection> createState() => _BookingDateTimeSectionState();
}

class _BookingDateTimeSectionState extends State<BookingDateTimeSection> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                _selectedDate = picked;
              });
              widget.onDateSelected(picked);
            }
          },
          icon: const Icon(Icons.calendar_today),
          label: Text(
            _selectedDate != null
                ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                : widget.label1,
          ),
          style: ElevatedButton.styleFrom(fixedSize: Size(150.w, 50.h)),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              setState(() {
                _selectedTime = picked;
              });
              widget.onTimeSelected(picked);
            }
          },
          icon: const Icon(Icons.access_time),
          label: Text(
            _selectedTime != null
                ? _selectedTime!.format(context)
                : widget.label2,
          ),
          style: ElevatedButton.styleFrom(fixedSize: Size(110.w, 50.h)),
        ),
      ],
    );
  }
}
