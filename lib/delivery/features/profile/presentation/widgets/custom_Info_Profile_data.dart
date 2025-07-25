import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_cubit.dart';

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
            onPressed: () async {
              // Navigate to the profile update page and wait for the result
              final result = await context.push<bool>(
                RouterNames.driverDetails,
              );

              // If returning from edit page with success result, refresh the profile data
              if (result == true && context.mounted) {
                // This will trigger a refresh of the parent widget showing this profile data
                context.read<DriverProfileInfoCubit>().fetchDriverProfile();
              }
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
