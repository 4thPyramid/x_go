import 'package:flutter/material.dart';

class CarDetailsHeader extends StatelessWidget {
  const CarDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Lamborghini', style: TextStyle(color: Colors.orange)),
        Text('Revuelto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text('Giza, Cairo, Egypt',
                style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400)),
          ],
        ),
      ],
    );
  }
}