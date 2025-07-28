import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_loggr.dart';

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 120.h,
                    width: 120.w,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.delivery_dining_rounded,
                      size: 80.sp,
                      color: theme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Welcome to X-Go',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Please select your role to continue',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 48.h),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Client Card
                    _buildUserTypeCard(
                      context: context,
                      icon: Icons.car_rental,
                      title: 'Client',
                      subtitle: 'Order food and track your delivery',
                      onTap: () {
                        final token = CacheHelper.getToken();
                        if (token != null && token.isNotEmpty) {
                          context.go(RouterNames.app); // رايح عالـ Home مباشرة
                        } else {
                          context.go(
                            RouterNames.splash,
                          ); // رايح يسجل أو يعمل login
                        }
                      },

                      color: theme.primaryColor,
                    ),

                    SizedBox(height: 24.h),

                    // Driver Card
                    _buildUserTypeCard(
                      context: context,
                      icon: Icons.delivery_dining_rounded,
                      title: 'Delivery Partner',
                      subtitle: 'Deliver orders and earn money',
                      onTap: () {
                        final driverId = CacheHelper.getDriverId();
                        AppLogger.d('Delivery id: $driverId');
                        if (driverId != null && driverId.isNotEmpty) {
                          context.go(
                            RouterNames.appDelivery,
                          ); // لو السواق مسجل دخول
                        } else {
                          context.go(
                            RouterNames.delivery,
                            extra: 0,
                          ); // يروح يسجل أو يعمل login
                        }
                      },
                      color: theme.primaryColor,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 16.h, top: 24.h),
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28.sp, color: color),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
