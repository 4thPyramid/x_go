import 'package:flutter/material.dart';
import 'package:x_go/features/payment/presentation/component/car_details_component.dart';
import 'package:x_go/features/payment/presentation/component/payment_component.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class PaymentView extends StatelessWidget {
  final CarEntity car;
  final String pickupDate;
  final String returnDate;
  const PaymentView({
    super.key,
    required this.car,
    required this.pickupDate,
    required this.returnDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarDetailsComponent(
                  car: car,
                  pickupDate: pickupDate,
                  returnDate: returnDate,
                ),
                const SizedBox(height: 32),

                PaymentComponent(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
