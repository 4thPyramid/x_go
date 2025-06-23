import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/logo.dart';
import 'package:x_go/features/auth/presentation/widgets/tab_bar_widget.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
          child: DefaultTabController(
            length: 2,
            initialIndex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                LogoWidget(),
                SizedBox(height: 10.h),
                TabBarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
