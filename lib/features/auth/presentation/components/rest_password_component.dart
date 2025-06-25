import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  const ResetPasswordComponent({super.key});

  @override
  State<ResetPasswordComponent> createState() => _ResetPasswordComponentState();
}

class _ResetPasswordComponentState extends State<ResetPasswordComponent> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
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
            controller: passwordController,
            isPassword: true,
            prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
            fillColor: Colors.grey.withValues(alpha: 0.3),
            keyboardType: TextInputType.visiblePassword,
            validator: Validator.validatePassword,
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
            controller: confirmPasswordController,
            isPassword: true,
            prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
            fillColor: Colors.grey.withValues(alpha: 0.3),
            keyboardType: TextInputType.visiblePassword,
            validator: Validator.validatePassword,
          ),

          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ResetPasswordError) {
                showToast(message: state.message, state: ToastStates.ERROR);
              } else if (state is ResetPasswordSuccess) {
                context.push(RouterNames.success_updated);
              }
            },
            builder: (context, state) {
              return state is ResetPasswordLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'Save New Password',
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            context.read<AuthCubit>().resetPassword(
                              'email@gmail.com',
                              '123456',
                            );
                          } else {
                            showToast(
                              message: 'Passwords do not match',
                              state: ToastStates.ERROR,
                            );
                          }
                        }
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
