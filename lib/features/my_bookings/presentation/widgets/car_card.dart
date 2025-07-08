import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة ثابتة
          Center(
            child: Image.network(
              'https://xgo.ibrahimbashaa.com/models/1751380183.png',
              height: 250,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // اسم السيارة والماركة
          const Text(
            'Benz - Mercedes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          // تواريخ الحجز
          const Text(
            'From: 2024-11-05 08:25:00',
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            'To:   2024-11-06 08:25:00',
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 10),

          // السعر والحالة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '\$8000.00',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Chip(
                label: const Text(
                  'PENDING',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
