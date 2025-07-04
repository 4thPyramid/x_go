import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/features/carBooking/presentation/views/car_booking_page.dart' show CarBookingPage;
import 'package:x_go/features/home/domain/entity/car_entity.dart';


class BookingButton extends StatelessWidget {
CarEntity care;
   BookingButton({super.key , required this.care});

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
