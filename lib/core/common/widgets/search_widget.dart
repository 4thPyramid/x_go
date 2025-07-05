import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onPressed, this.icon});
  final void Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Expanded(
        child: Container(
          alignment: Alignment.topRight,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.fillGrey,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: TextFormField(
            onTap: onPressed,
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: 'ابحث عن منتج',
              hintStyle: TextStyle(color: AppColors.grey),
              prefixIcon: Icon(Icons.search, color: AppColors.fillGrey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
    );
  }
}
