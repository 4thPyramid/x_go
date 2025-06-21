import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.iconleft,
    this.iconright,
    this.onPressedLeft,
    this.onPressedRight,
    this.padding,
  });

  final String title;
  final IconData? iconleft;
  final IconData? iconright;
  final VoidCallback? onPressedLeft;
  final VoidCallback? onPressedRight;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding ?? 70.h, bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
  
          iconleft != null
              ? IconButton(
                  onPressed: onPressedLeft,
                  icon: Icon(
                    iconleft,
                    color: AppColors.primaryColor,
                  ),
                )
              : const SizedBox(),
          
          // Title
          Text(
            title,
            style: AppStyles.s24,
          ),
          
          // Right IconButton
          iconright != null
              ? IconButton(
                  onPressed: onPressedRight,
                  icon: Icon(
                    iconright,
                    color: AppColors.primaryColor,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

