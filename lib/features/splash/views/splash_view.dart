import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';
import 'package:x_go/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/features/splash/widgets/dark_overlay.dart';
import 'package:x_go/features/splash/widgets/header_splash.dart';
import 'package:x_go/features/splash/widgets/outline_button.dart';

bool isGuest = false;

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: AppImageView(AppAssets.splash, fit: BoxFit.cover),
          ),
          // Dark Overlay
          darkOverlay(),
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     final authToken = await PaymobService.getAuthToken();
                  //     final orderId = await PaymobService.createOrder(
                  //       authToken,
                  //       int.parse('100') * 100,
                  //     );
                  //     final paymentKey = await PaymobService.getPaymentKey(
                  //       authToken,
                  //       orderId,
                  //       int.parse('100') * 100,
                  //     );
                  //     String paymentUrl =
                  //         "https://accept.paymob.com/api/acceptance/iframes/905872?payment_token=$paymentKey";
                  //     // ignore: use_build_context_synchronously
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) =>
                  //             PaymobPaymentScreen(iframeUrl: paymentUrl),
                  //       ),
                  //     );
                  //   },
                  //   child: Text('Test'),
                  // ), // Logo
                  Center(child: AppImageView(AppAssets.logo)),
                  SizedBox(height: 10.h),
                  HeaderSplash(),
                  Spacer(),
                  CustomButton(
                    height: 44.h,

                    text: 'Start Driving',
                    onPressed: () {
                      isGuest = true;
                      context.go(RouterNames.app);
                    },
                  ),
                  SizedBox(height: 12.h),
                  buildOutlineButton(
                    text: 'Login',
                    onPressed: () {
                      context.go(RouterNames.auth, extra: 0);
                    },
                  ),
                  SizedBox(height: 12.h),
                  buildOutlineButton(
                    text: 'Register',
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
