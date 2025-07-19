import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

Widget buildSplashRichText() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'Your ',
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      children: [
        TextSpan(
          text: 'Sporty ',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        TextSpan(
          text: 'Drive ',
          style: TextStyle(color: Colors.white),
        ),
        TextSpan(
          text: 'Starts ',
          style: TextStyle(color: Colors.white),
        ),
        TextSpan(
          text: 'Here!',
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
