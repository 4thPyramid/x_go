import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/carBooking/presentation/components/car_booking_card.dart';

import 'package:x_go/features/carBooking/presentation/widgets/car_details_haeder.dart';
import 'package:x_go/features/carBooking/presentation/widgets/car_image_caursol_widget.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class CarBookingPage extends StatelessWidget {
  final CarEntity car;
  const CarBookingPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/logo.png', height: 44.h),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarImageCarouselWidget(car: car),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarDetailsHeader(car: car),
                        const SizedBox(height: 16),
                        BookingCardComponent(car: car),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
