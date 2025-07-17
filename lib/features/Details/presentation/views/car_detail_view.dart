// features/Details/presentation/views/car_detail_view.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
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
        title: Image.asset('assets/images/logo.png', height: 40.h),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220.h,
              width: double.infinity,
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: car.image.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: car.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
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
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.brandName,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    car.modelName,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Cairo, Egypt',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    'Car Details',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CarInfoSection(car: car),
                  SizedBox(height: 18.h),
                  Container(
                    padding: EdgeInsets.all(16.w),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.rentPrice.tr(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              car.price,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' /1 Day',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  BookingButton(care: car),
                  SizedBox(height: 24.h),
                  Center(
                    child: CustomButton(
                      text: 'Add Review',
                      onPressed: () {
                        context.push(RouterNames.review, extra: car.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
