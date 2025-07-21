import 'package:flutter/material.dart';

class WithDeliveryOrderTab extends StatelessWidget {
  const WithDeliveryOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add more widgets here as needed
        Text(
          'With Delivery Order Tab',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // You can add more widgets to display with delivery order requests
      ],
    );
  }
}
