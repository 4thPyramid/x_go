import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        actions: [IconButton(icon: const Icon(Icons.star_border), onPressed: () {})],
        title: Image.asset('assets/images/logo.png', height: 40),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          SizedBox(
            height: 180.h,
            child: Image.asset('assets/images/Group 7.png',
            fit: BoxFit.cover,
            width: double.infinity,),
          ),
           Padding( 
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lamborghini', style: TextStyle(color: Colors.orange, fontSize:12.sp)),
                SizedBox(height:7.h),
                Text('Revuelto', style: TextStyle(fontSize: 20, fontWeight:FontWeight.w500)),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16),
                    SizedBox(height: 7.h),
                    Text('Giza, Cairo, Egypt', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400)),
                  ],
                ),
                SizedBox(height: 15.h),
                CarInfoSection(),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    Text('Rent Price', style: TextStyle( fontSize: 16.sp, fontWeight: FontWeight.w400)),
                    Spacer(),
                    Text('\$1400 ', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                    Text('/day', style: TextStyle( fontSize: 16.sp, fontWeight: FontWeight.w400)),
                  ],
                ),
                SizedBox(height: 20.h),
                BookingButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}
