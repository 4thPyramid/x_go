import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';

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
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.push(RouterNames.popularCars);
                },
                child: Text('View all', style: TextStyle(fontSize: 14.sp)),
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
