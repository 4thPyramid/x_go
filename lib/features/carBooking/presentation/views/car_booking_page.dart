import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/carBooking/presentation/components/car_booking_card.dart';
import 'package:x_go/features/carBooking/presentation/components/carimage_carousel_component.dart';
import 'package:x_go/features/carBooking/presentation/logic/cubit/car_booking_cubit.dart';
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
      body: BlocProvider(
        create: (context) => CarBookingCubit(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarImageCarouselComponent(),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CarBookingCubit>().bookCar();
                      },
                      child: Text('Set Location'),
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
                            isAdditionalDriverChecked:
                                isAdditionalDriverChecked,
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
      ),
    );
  }
}
