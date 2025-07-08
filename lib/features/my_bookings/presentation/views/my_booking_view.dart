import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/features/my_bookings/presentation/widgets/car_card.dart';

class MyBookingView extends StatelessWidget {
  const MyBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF5EF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3, // عدد الكروت اللي عايز تظهرها
        itemBuilder: (context, index) => const BookingCard(),
      ),
    );
  }
}
