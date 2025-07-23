import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class CustomInfoProfileData extends StatelessWidget {
  const CustomInfoProfileData({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90.h,
      left: 20.w,
      right: 20.w,
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.h),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Handle edit action
              },
            ),
            leading: CircleAvatar(
              radius: 25.r,
              child: Icon(Icons.person, size: 32.sp, color: AppColors.black),
            ),
            title: Text(
              'John Doe',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Delivery Driver',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
