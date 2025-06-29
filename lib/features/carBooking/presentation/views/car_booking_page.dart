// file: car_booking_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/carBooking/presentation/components/car_booking_card.dart';
import 'package:x_go/features/carBooking/presentation/components/car_image_caursol.dart';
import 'package:x_go/features/carBooking/presentation/widgets/car_details_haeder.dart';

class CarBookingPage extends StatefulWidget {
  const CarBookingPage({super.key});

  @override
  State<CarBookingPage> createState() => _CarBookingPageState();
}

class _CarBookingPageState extends State<CarBookingPage> {
  bool isAdditionalDriverChecked = false;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> imageList = [
    'assets/images/Group 7.png',
    'assets/images/Group 7.png',
    'assets/images/Group 7.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/logo.png', height: 44.h),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarImageCarousel(
                    images: imageList,
                    controller: _pageController,
                    currentIndex: _currentPage,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CarDetailsHeader(),
                        const SizedBox(height: 16),
                        BookingCard(
                          isAdditionalDriverChecked: isAdditionalDriverChecked,
                          onAdditionalDriverChanged: (value) {
                            setState(() {
                              isAdditionalDriverChecked = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
