import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/features/carBooking/booking_date_time_picker.dart';
import 'package:x_go/features/payment/presentation/views/payment_view.dart';

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
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: Image.asset('assets/images/logo.png', height: 40),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCarousel(),
            const SizedBox(height: 8),
            buildIndicator(),

            const SizedBox(height: 16),
            const Text('Lamborghini', style: TextStyle(color: Colors.orange)),
            const Text('Revuelto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            Row(
              children: const [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text('Giza, Cairo, Egypt'),
              ],
            ),

            const SizedBox(height: 16),

            Card(
              color: const Color(0xFFFAF7F2),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text('Select Location', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp)),
                    const SizedBox(height: 8),

                    const CustomTextFormField(
                     

                      prefixIcon: Icon(Icons.pin_drop),
                      labelText: 'Add Pickup Location',
                    ),

                    const SizedBox(height: 8),

                    const CustomTextFormField(
                      prefixIcon: Icon(Icons.pin_drop),
                      labelText: 'Add Return Location',
                    ),

                    const SizedBox(height: 35),

                     Text('Pickup', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp)),
                    const SizedBox(height: 15),

                    const Row(
                      children: [
                        Expanded(child: BookingDateTimePicker(label: 'From Date',prefixIcon: Icon(Icons.calendar_today ,))),
                        SizedBox(width: 8),
                        Expanded(child: BookingDateTimePicker(label: 'Time',prefixIcon: Icon(Icons.access_time ,),)),
                      ],
                    ),

                    const SizedBox(height: 20),

                     Text('Return', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp)),
                    const SizedBox(height: 15),

                    const Row(
                      children: [
                        Expanded(child: BookingDateTimePicker(label: 'To Date',prefixIcon: Icon(Icons.calendar_today ,))),
                        SizedBox(width: 8),
                        Expanded(child: BookingDateTimePicker(label: 'Time',prefixIcon: Icon(Icons.access_time ,))),
                      ],
                    ),

                     SizedBox(height: 35.h),

                    Row(
                      children: [
                        Checkbox(
                          value: isAdditionalDriverChecked,
                          onChanged: (value) {
                            setState(() {
                              isAdditionalDriverChecked = value!;
                            });
                          },
                        ),
                        const Text('Additional Driver'),
                      ],
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PaymentScreen()),
                          );
                        },
                        child: const Text('Confirm'),
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

  Widget buildCarousel() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: imageList.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageList[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageList.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == entry.key ? Colors.orange : Colors.grey.shade400,
          ),
        );
      }).toList(),
    );
  }
}
