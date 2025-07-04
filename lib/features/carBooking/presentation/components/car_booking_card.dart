import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/carBooking/presentation/widgets/booking_location_field.dart';
import 'package:x_go/features/carBooking/presentation/widgets/boooking_data_time_section.dart';
import 'package:x_go/features/carBooking/presentation/widgets/driver_check_box.dart';


class BookingCard extends StatelessWidget {
  final bool isAdditionalDriverChecked;
  final void Function(bool?) onAdditionalDriverChanged;

  const BookingCard({
    required this.isAdditionalDriverChecked,
    required this.onAdditionalDriverChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFAF7F2),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Location', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
            const SizedBox(height: 8),
            const BookingLocationFields(),
            const SizedBox(height: 35),
            Text('Pickup', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
            const SizedBox(height: 15),
            const BookingDateTimeSection(label1: 'From Date', label2: 'Time'),
            const SizedBox(height: 20),
            Text('Return', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
            const SizedBox(height: 15),
            const BookingDateTimeSection(label1: 'To Date', label2: 'Time'),
            SizedBox(height: 35.h),
            AdditionalDriverCheckbox(
              value: isAdditionalDriverChecked,
              onChanged: onAdditionalDriverChanged,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                 context.go(RouterNames.payment);
                },
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
