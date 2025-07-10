import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';

class OtpDetailsWidget extends StatelessWidget {
  const OtpDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Text(
              'Enter OTP Code',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            AppImageView(AppAssets.lock),
          ],
        ),
        SizedBox(height: 24.h),
        Text(
          'Lorem ipsum dolor sit amet consectetur. Eu id porta ac sed dolor massa libero. Magnis cursus lacus semper amet. ',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
