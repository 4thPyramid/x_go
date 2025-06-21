import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';

class CustomIconBackWidget extends StatelessWidget {
  const CustomIconBackWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h, left: 16.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
