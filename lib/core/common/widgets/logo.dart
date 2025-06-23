import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      color: Color(0xff685321),
      height: 70.h,
      width: 170.w,
      fit: BoxFit.contain,
    );
  }
}
