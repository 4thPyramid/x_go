import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/auth/login/presentation/components/login_form.dart';
import 'package:x_go/features/auth/login/presentation/components/register_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: const _AuthScreen(),
    );
  }
}

class _AuthScreen extends StatelessWidget {
  const _AuthScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  color: AppColors.primaryColor,
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 24.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TabBar(
                          tabs: [
                            Tab(text: 'Login'),
                            Tab(text: 'Register'),
                          ],
                          labelColor: Colors.black,
                          unselectedLabelColor: AppColors.primaryColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 700.h,
                        child: TabBarView(
                          children: [LoginForm(), RegisterForm()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
