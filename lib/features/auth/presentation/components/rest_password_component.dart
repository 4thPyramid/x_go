import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/routes/router_names.dart';

class ResetPasswordComponent extends StatelessWidget {
  const ResetPasswordComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Create New Password',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          labelText: 'New Password',
          isPassword: true,
          prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
          fillColor: Colors.grey.withValues(alpha: 0.3),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Confirm New Password',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          labelText: 'Confirm New Password',
          isPassword: true,
          prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
          fillColor: Colors.grey.withValues(alpha: 0.3),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),

        SizedBox(height: 24.h),
        CustomButton(
          text: 'Save New Password',
          onPressed: () {
            context.push(RouterNames.success_updated);
          },
        ),
      ],
    );
  }
}
