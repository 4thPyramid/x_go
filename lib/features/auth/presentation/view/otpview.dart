import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/style.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Text(
                      'Enter OTP Code',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/images/lock.svg"),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Eu id porta ac sed dolor massa libero. Magnis cursus lacus semper amet. ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h),

                SizedBox(height: 8.h),
                OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,

                  fieldWidth: 40,

                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,

                  onCompleted: (pin) {
                    print("Entered OTP is: $pin");
                  },
                ),
                SizedBox(height: 24.h),
                Text(
                  'You can resend the code in 35 sec',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(onPressed: () {}, child: Text('Resend Code')),
                SizedBox(height: 24.h),
                CustomButton(
                  text: 'Send OTP Code',
                  onPressed: () {
                    context.pushNamed(RouterNames.otp);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
