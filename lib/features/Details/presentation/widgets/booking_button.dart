import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';

class BookingButton extends StatelessWidget {
  const BookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Book Now',
      onPressed: () {
        context.push(RouterNames.carBooking);
      },
    );
  }
}
