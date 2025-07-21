import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';

class AppBarDeliveryHome extends StatelessWidget {
  const AppBarDeliveryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
                size: 20,
              ),
              onPressed: () {
                //
              },
            ),
            Text(
              'Manor, Egypt',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: AppColors.primaryColor, size: 28.w),
          onPressed: () {
            context.push(RouterNames.customSearchDeliveryApp);
          },
        ),
      ],
    );
  }
}
