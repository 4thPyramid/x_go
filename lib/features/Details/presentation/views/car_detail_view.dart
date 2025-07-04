import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/features/Details/presentation/widgets/booking_button.dart';
import 'package:x_go/features/Details/presentation/widgets/car_info_section.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class CarDetailsPage extends StatelessWidget {
  final CarEntity car;

  const CarDetailsPage({super.key, required this.car});

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
        title: Image.asset('assets/images/logo.png', height: 40.h),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          SizedBox(
            height: 180.h,
            child: car.image.startsWith('http')
                ? CachedNetworkImage(
              imageUrl: car.image,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/Group7.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
                : Image.asset(
              car.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.brandName,
                  style: TextStyle(color: Colors.orange, fontSize: 12.sp),
                ),
                SizedBox(height: 7.h),
                Text(
                  car.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    SizedBox(width: 4.w),
                    Text(
                      'caio /Egypt',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                CarInfoSection(car: car),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    Text(
                      AppStrings.rentPrice.tr(),
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Text(
                      '${car.price}  ',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),

                  ],
                ),
                SizedBox(height: 20.h),
                BookingButton(
                  care: car,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
