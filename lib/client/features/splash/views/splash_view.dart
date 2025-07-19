import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/splash/widgets/dark_overlay.dart';
import 'package:x_go/client/features/splash/widgets/header_splash.dart';
import 'package:x_go/client/features/splash/widgets/outline_button.dart';

bool isGuest = false;

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: AppImageView(AppAssets.splash, fit: BoxFit.cover),
          ),
          darkOverlay(),
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  Center(child: AppImageView(AppAssets.logo)),
                  SizedBox(height: 10.h),
                  HeaderSplash(),
                  Spacer(),
                  CustomButton(
                    height: 44.h,

                    text: AppStrings.startDriving.tr(),
                    onPressed: () {
                      isGuest = true;
                      context.go(RouterNames.app);
                    },
                  ),
                  SizedBox(height: 12.h),
                  buildOutlineButton(
                    text: AppStrings.login.tr(),
                    onPressed: () {
                      context.go(RouterNames.auth, extra: 0);
                    },
                  ),
                  SizedBox(height: 12.h),
                  buildOutlineButton(
                    text: AppStrings.register.tr(),
                    onPressed: () {
                      context.go(RouterNames.auth, extra: 1);
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
