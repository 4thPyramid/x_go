import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class FilterFooterButtons extends StatelessWidget {
  final VoidCallback? onClearPressed;
  final VoidCallback? onApplyPressed;

  const FilterFooterButtons({
    super.key,
    this.onClearPressed,
    this.onApplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.lightBorderGrey, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Clear Button
            Expanded(child: _buildClearButton()),

            SizedBox(width: 12.w),

            // Apply Button
            Expanded(flex: 2, child: _buildApplyButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightBorderGrey),
      ),
      child: TextButton(
        onPressed: onClearPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Clear',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      height: 48.h,
      child: ElevatedButton(
        onPressed: onApplyPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Apply Filters',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
