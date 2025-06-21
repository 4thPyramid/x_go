import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.height,
    this.width,
    this.textStyle,
    this.borderRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: GestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: Container(
          height: height ?? 44.h,
          width: width ?? 230.w,
          decoration: BoxDecoration(
            color: isDisabled
                ? Colors
                      .grey // أو لون معبر عن التعطيل
                : backgroundColor ?? AppColors.primaryColor,
            borderRadius: borderRadius ?? BorderRadius.circular(28),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(text, style: textStyle ?? AppStyles.s16White),
          ),
        ),
      ),
    );
  }
}
