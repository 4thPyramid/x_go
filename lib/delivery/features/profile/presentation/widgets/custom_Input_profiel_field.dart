import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

Widget buildInputField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      SizedBox(height: 8.h),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.grey, fontSize: 14.sp),
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          filled: true,
          fillColor: AppColors.lightGrey.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    ],
  );
}
