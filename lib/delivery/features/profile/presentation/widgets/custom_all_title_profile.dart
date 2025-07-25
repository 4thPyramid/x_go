import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/client/features/language/presentation/view/language_view.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';

class CustomAllTitleProfile extends StatelessWidget {
  const CustomAllTitleProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 7.0.w),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.0.w, top: 8.0.h),
              child: Text(
                'Delivery Profile',
                style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w700),
              ),
            ),

            LanguageDropdownTile(),
            ProfileItemTile(
              title: 'Notifications',
              titleStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
              onTap: () {
                // configure notifications
              },
              icon: Icons.notifications,
              isSwitch: true,
              switchValue: true,
              onSwitchChanged: (value) {
                // Handle switch change
              },
            ),
            ProfileItemTile(
              title: 'Help & Support',
              titleStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
              onTap: () {
                // Navigate to My DriverDetails page
              },
              icon: Icons.help_outline,
            ),
            ProfileItemTile(
              title: 'Logout',
              titleStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.red,
              ),
              onTap: () {
                // Handle logout action
                CacheHelper.deleteToken();
                context.go(RouterNames.userType);
                //AppLogger.d('User logged out');
              },
              icon: Icons.logout_rounded,
              color: AppColors.red,
              showTrailing: false,
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
