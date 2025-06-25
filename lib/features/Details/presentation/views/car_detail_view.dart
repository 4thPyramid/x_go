import 'package:flutter/material.dart';
import 'package:x_go/features/Details/presentation/widgets/booking_button.dart';
import 'package:x_go/features/Details/presentation/widgets/car_info_section.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.star_border), onPressed: () {}),
        ],
        title: Image.asset('assets/images/logo.png', height: 40),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset('assets/images/Group 7.png'),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lamborghini', style: TextStyle(color: Colors.orange)),
                SizedBox(height: 4),
                Text(
                  'Revuelto',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16),
                    SizedBox(width: 4),
                    Text('Giza, Cairo, Egypt'),
                  ],
                ),
                SizedBox(height: 8),
                CarInfoSection(),
                SizedBox(height: 12),
                Text('Rent Price', style: TextStyle(color: Colors.grey)),
                Text(
                  '\$1400 / Day',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                BookingButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
