import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';

class CustomInfoProfileData extends StatelessWidget {
  const CustomInfoProfileData({super.key, required this.driverProfileEntity});
  final DriverProfileEntity driverProfileEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
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
            driverProfileEntity.name ?? '',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            driverProfileEntity.email ?? 'Email not provided',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
