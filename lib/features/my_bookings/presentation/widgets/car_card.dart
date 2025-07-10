import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/my_bookings/data/models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String model;
  final String modelYear;
  final String fromDate;
  final String toDate;
  final String price;
  final String status;

  final CarEntity? car;
  final MyBookingModel? myBookingModel;
  final BookingModel? bookingModel;

  const BookingCard({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.modelYear,
    required this.fromDate,
    required this.toDate,
    required this.price,
    required this.status,
    this.car,
    this.myBookingModel,
    this.bookingModel,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'initiated':
        return Colors.blue;
      case 'awaiting_payment':
        return Colors.amber;
      case 'payment_pending':
        return Colors.red;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(14),
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
            child: Image.network(
              imageUrl.startsWith("http")
                  ? imageUrl
                  : 'https://xgo.ibrahimbashaa.com/$imageUrl',
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$brand - $model ($modelYear)',
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
              InkWell(
                onTap: () {
                  context.push(
                    RouterNames.payment,
                    extra: {
                      'myBookingModel': myBookingModel,
                      'car': car,
                      'model': bookingModel,
                    },
                  );
                },
                child: Chip(
                  label: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: getStatusColor(status),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
