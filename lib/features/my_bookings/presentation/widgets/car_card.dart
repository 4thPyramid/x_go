import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String model;
  final String fromDate;
  final String toDate;
  final String price;
  final String status;

  const BookingCard({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.fromDate,
    required this.toDate,
    required this.price,
    required this.status,
  });

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
          Center(
            child: Image.network(imageUrl, height: 250, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Text(
            '$brand - $model',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text('From: $fromDate', style: const TextStyle(color: Colors.grey)),
          Text('To:   $toDate', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Chip(
                label: Text(
                  status.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
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
