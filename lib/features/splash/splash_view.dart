import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.asset('assets/images/splash.png', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', height: 100.h),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Your ',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sporty ',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      TextSpan(
                        text: 'Drive ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Starts ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Here!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CustomButton(
                  text: 'Get Started',
                  onPressed: () {
                    context.go(RouterNames.app);
                  },
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
