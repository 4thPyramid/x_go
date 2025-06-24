import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/routes/router_names.dart';

class ForgetPasswordComponent extends StatelessWidget {
  const ForgetPasswordComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Registered email address',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          labelText: 'Email',
          prefixIcon: Icon(Icons.email, color: Colors.grey[600]),
          fillColor: Colors.grey.withValues(alpha: 0.3),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        SizedBox(height: 24.h),
        CustomButton(
          text: 'Send OTP Code',
          onPressed: () {
            context.push(RouterNames.otp);
          },
        ),
      ],
    );
  }
}
