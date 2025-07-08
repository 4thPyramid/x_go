import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PopularCarsComponent extends StatelessWidget {
  const PopularCarsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Text(
                'Popular',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to full list
                },
                child: Text(
                  'View all',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 5.h),
        // Vertical List
      ],
    );
  }
}
