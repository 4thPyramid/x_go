import 'package:flutter/material.dart';
import 'package:x_go/core/utils/app_styles.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';

class CarDetailsFromMyBooking extends StatelessWidget {
  final MyBookingModel model;

  const CarDetailsFromMyBooking({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          model.carImage ?? '',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            model.brandName ?? '',
            style: AppStyles.ts13BlackW500.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(model.modelName ?? '', style: AppStyles.ts13BlackW500),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text('Trip Dates: ${model.startDate} -- ${model.endDate}'),
              const SizedBox(height: 10),
              Text(model.additionalDriver == 1
                  ? 'With additional driver'
                  : 'Without additional driver'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('\$${model.finalPrice}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
