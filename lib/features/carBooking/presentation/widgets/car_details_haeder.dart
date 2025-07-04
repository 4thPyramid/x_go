import 'package:flutter/material.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class CarDetailsHeader extends StatelessWidget {
  final CarEntity? car;
  const CarDetailsHeader({super.key, this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(car!.name, style: TextStyle(color: Colors.orange)),
        Text(
          car!.brandName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text(
              'Giza, Cairo, Egypt',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
