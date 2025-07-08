import 'package:flutter/material.dart';
import 'package:x_go/core/common/widgets/logo.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/payment/presentation/component/car_details_component.dart';
import 'package:x_go/features/payment/presentation/component/payment_component.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class PaymentView extends StatelessWidget {
  final CarEntity car;
  final BookingModel booking_model;
  const PaymentView({
    super.key,
    required this.car,
    required this.booking_model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: LogoWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarDetailsComponent(car: car, booking_model: booking_model),
                const SizedBox(height: 32),

                PaymentComponent(
                  finalPrice: booking_model.data!.booking!.finalPrice
                      .toString(),
                  modelId: booking_model.data!.booking!.carmodelId!.toString(),
                  bookingId: booking_model.data!.booking!.id!.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
