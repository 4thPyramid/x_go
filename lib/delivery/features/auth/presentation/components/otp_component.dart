import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';

class OtpComponent extends StatelessWidget {
  final String email;
  const OtpComponent({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    String? otp;
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
        return Column(
          children: [
            SizedBox(height: 8.h),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              otpFieldStyle: OtpFieldStyle(
                focusBorderColor: AppColors.primaryColor,
                disabledBorderColor: AppColors.primaryColor,
                backgroundColor: Colors.grey.withValues(alpha: 0.3),
              ),
              fieldWidth: 40,

              style: TextStyle(fontSize: 17.sp),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,

              onCompleted: (pin) {
                otp = pin;
                context.read<AuthCubit>().otp(email, pin);
              },
            ),
            SizedBox(height: 14.h),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return state is ForgotPasswordLoading
                    ? Text(
                        AppStrings.waitForOtp.tr(),
                        style: TextStyle(color: AppColors.primaryColor),
                      )
                    : TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().forgetPassword(email);
                        },
                        child: Text(AppStrings.resendCode.tr()),
                      );
              },
            ),
            SizedBox(height: 14.h),
            BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                return state is OtpLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: AppStrings.verify.tr(),
                        onPressed: () {
                          context.read<AuthCubit>().otp(email, otp!);
                        },
                      );
              },
              listener: (BuildContext context, AuthState state) {
                if (state is OtpSuccess) {
                  showToast(message: state.message, state: ToastStates.SUCCESS);
                  context.push(
                    RouterNames.resetPassword,
                    extra: {'email': email, 'otp': otp},
                  );
                } else if (state is OtpError) {
                  showToast(message: state.message, state: ToastStates.ERROR);
                } else if (state is ForgotPasswordSuccess) {
                  showToast(message: state.message, state: ToastStates.SUCCESS);
                } else if (state is ForgotPasswordError) {
                  showToast(message: state.message, state: ToastStates.ERROR);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
