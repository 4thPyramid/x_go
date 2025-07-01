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
import 'package:x_go/features/auth/presentation/logic/cubit/auth_cubit.dart';

class OtpComponent extends StatelessWidget {
  String? email;
  OtpComponent({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    String? otp;
    return Column(
      children: [
        SizedBox(height: 8.h),
        OTPTextField(
          length: 4,

          width: MediaQuery.of(context).size.width,
          otpFieldStyle: OtpFieldStyle(
            focusBorderColor: AppColors.primaryColor,
            disabledBorderColor: AppColors.primaryColor,
            backgroundColor: Colors.grey.withValues(alpha: 0.3),
          ),
          fieldWidth: 40,

          style: TextStyle(fontSize: 17),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box,

          onCompleted: (pin) {
            print("Entered OTP is: $pin");
            otp = pin;
            context.read<AuthCubit>().otp(email!, pin);
          },
        ),
        SizedBox(height: 24.h),
        Text(
          'You can resend the code in 35 sec',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
        TextButton(onPressed: () {}, child: Text('Resend Code')),
        SizedBox(height: 24.h),
        BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            return state is OtpLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: 'Verify',
                    onPressed: () {
                      // context.push(RouterNames.resetPassword);
                      context.read<AuthCubit>().otp(email!, otp!);
                    },
                  );
          },
          listener: (BuildContext context, AuthState state) {
            if (state is OtpSuccess) {
              context.push(RouterNames.resetPassword);
            } else if (state is OtpError) {
              showToast(message: state.message, state: ToastStates.ERROR);
            }
          },
        ),
      ],
    );
  }
}
