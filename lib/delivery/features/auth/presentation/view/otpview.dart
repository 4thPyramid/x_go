import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/client/features/language/presentation/logic/cubit/lang_cupit.dart';
import 'package:x_go/delivery/features/auth/presentation/components/otp_component.dart';
import 'package:x_go/delivery/features/auth/presentation/widgets/otp_details_widget.dart';

class DeliveryOtpView extends StatelessWidget {
  final String email;
  const DeliveryOtpView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 100.h),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24.w),
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
                    OtpDetailsWidget(),
                    SizedBox(height: 24.h),
                    OtpComponent(email: email),
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
