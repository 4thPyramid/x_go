import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/common/functions/password_visibility_cubit.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.controller,
    this.validator,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10.h),
        isPassword
            ? BlocBuilder<PasswordVisibilityCubit, bool>(
                builder: (context, obscureText) {
                  return CustomTextFormField(
                    controller: controller,
                    labelText: labelText,
                    hintText: hint,
                    isPassword: true,
                    obscureText: obscureText,
                    toggleObscure: () {
                      context
                          .read<PasswordVisibilityCubit>()
                          .togglePasswordVisibility();
                    },
                    prefixIcon: Icon(icon, color: Colors.grey[600]),
                    keyboardType: keyboardType,
                    validator: validator,
                  );
                },
              )
            : CustomTextFormField(
                controller: controller,
                labelText: labelText,
                hintText: hint,
                isPassword: false,
                obscureText: false,
                prefixIcon: Icon(icon, color: Colors.grey[600]),
                keyboardType: keyboardType,
                validator: validator,
              ),
      ],
    );
  }
}
