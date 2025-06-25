import 'package:flutter/material.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/features/carBooking/presentation/views/car_booking_page.dart' show CarBookingPage;


class BookingButton extends StatelessWidget {
  const BookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Book Now',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CarBookingPage()),
        );
      },
    );
  }
}
