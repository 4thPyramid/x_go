import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      AppImageView(
        AppAssets.logo,
        height: 70.h,
        width: 170.w,
        fit: BoxFit.contain,
      );
  }
}
