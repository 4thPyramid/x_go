import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class BookingButton extends StatelessWidget {
  final CarEntity car;
  const BookingButton({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        text: 'Book Now',
        onPressed: () {
          context.push(RouterNames.carBooking, extra: car);
        },
      ),
    );
  }
}
