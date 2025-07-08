import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordDetailWidget extends StatelessWidget {
  const ForgetPasswordDetailWidget({super.key});

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
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Text(
              'Forgot Password',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            SvgPicture.asset('assets/images/key.svg'),
          ],
        ),
        SizedBox(height: 24.h),
        Text(
          'Lorem ipsum dolor sit amet consectetur. Eu id porta ac sed dolor massa libero. Magnis cursus lacus semper amet. ',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
