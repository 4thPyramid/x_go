import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/functions/validator.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/auth/presentation/logic/cubit/auth_cubit.dart';

class ResetPasswordComponent extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordComponent({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordComponent> createState() => _ResetPasswordComponentState();
}

class _ResetPasswordComponentState extends State<ResetPasswordComponent> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildPasswordField(),
          SizedBox(height: 20.h),
          _buildConfirmPasswordField(),
          SizedBox(height: 25.h),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ResetPasswordError) {
                showToast(message: state.message, state: ToastStates.ERROR);
              } else if (state is ResetPasswordSuccess) {
                showToast(message: state.message, state: ToastStates.SUCCESS);
                context.push(RouterNames.success_updated);
              }
            },
            builder: (context, state) {
              if (state is ResetPasswordLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomButton(
                text: 'Save New Password',
                onPressed: _handleResetPassword,
              );
            },
          ),
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text != _confirmPasswordController.text) {
        showToast(message: 'Passwords do not match', state: ToastStates.ERROR);
        return;
      }
      context.read<AuthCubit>().resetPassword(
        widget.email,
        _passwordController.text,
        widget.otp,
      );
    }
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create New Password',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          controller: _passwordController,
          isPassword: true,
          prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
          fillColor: Colors.grey.withOpacity(0.3),
          keyboardType: TextInputType.visiblePassword,
          validator: Validator.validatePassword,
          obscureText: !_isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm New Password',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          controller: _confirmPasswordController,
          isPassword: true,
          prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
          fillColor: Colors.grey.withOpacity(0.3),
          keyboardType: TextInputType.visiblePassword,
          validator: Validator.validatePassword,
          obscureText: !_isConfirmPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: _toggleConfirmPasswordVisibility,
          ),
        ),
      ],
    );
  }
}
