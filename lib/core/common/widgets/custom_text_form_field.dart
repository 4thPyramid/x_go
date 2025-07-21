import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final void Function()? toggleObscure;
  final TextInputType? keyboardType;
  final String? labelText;
  final void Function(String)? onchanged;
  final List<String>? autofillHints;
  final double? verticalPadding;
  final double? horizontalPadding;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.maxLines = 1,
    this.suffixIcon,
    this.fillColor,
    this.prefixIcon,
    this.isPassword = false,
    this.toggleObscure,
    this.keyboardType,
    this.labelText,
    this.onchanged,
    this.autofillHints,
    this.verticalPadding,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 18.0.w,
          horizontal: horizontalPadding ?? 12.0.w,
        ),
        hintText: hintText,

        hintStyle: AppStyles.ts14BlackW500.copyWith(color: AppColors.black),
        fillColor: fillColor ?? AppColors.white,
        filled: true,
        labelText: labelText,
        labelStyle: AppStyles.ts12GreyW400.copyWith(color: AppColors.grey),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: toggleObscure,
                icon: Visibility(
                  visible: obscureText,
                  replacement: const Icon(Icons.visibility_outlined),
                  child: const Icon(Icons.visibility_off_outlined),
                ),
                color: AppColors.grey,
              )
            : suffixIcon,

        prefixIcon: prefixIcon,
        border: InputBorder.none,

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
      ),
      validator: validator ?? (value) => null,
      onChanged: onchanged,
      maxLines: maxLines,
    );
  }
}
