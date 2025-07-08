import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class PopIconWidget extends StatelessWidget {
  const PopIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16.h,
      right: 18.w,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        splashColor: Colors.grey,
        highlightColor: Colors.grey,
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4.r,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black54),
        ),
      ),
    );
  }
}
