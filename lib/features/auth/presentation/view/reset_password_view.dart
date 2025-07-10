import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/auth/presentation/components/rest_password_component.dart';
import 'package:x_go/features/auth/presentation/widgets/reset_password_details.dart';
import 'package:x_go/features/language/presentation/logic/cubit/lang_cupit.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 75.h),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20.w),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ResetPasswordDetails(),
                    SizedBox(height: 20.h),
                    ResetPasswordComponent(email: email, otp: otp),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
