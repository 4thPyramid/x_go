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

class ForgetPasswordComponent extends StatelessWidget {
  const ForgetPasswordComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
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
            controller: _emailController,
            prefixIcon: Icon(Icons.email, color: Colors.grey[600]),
            fillColor: Colors.grey.withValues(alpha: 0.3),
            keyboardType: TextInputType.emailAddress,
            validator: Validator.validateEmail,
          ),
          SizedBox(height: 24.h),
          BlocConsumer<AuthCubit, AuthState>(
            builder: (context, state) {
              return state is ForgotPasswordLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'Send OTP Code',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().forgetPassword(
                            _emailController.text,
                          );
                        }
                      },
                    );
            },
            listener: (BuildContext context, AuthState state) {
              if (state is ForgotPasswordSuccess) {
                showToast(message: state.message, state: ToastStates.SUCCESS);
                context.push(RouterNames.otp, extra: _emailController.text);
              } else if (state is ForgotPasswordError) {
                showToast(message: state.message, state: ToastStates.ERROR);
              }
            },
          ),
        ],
      ),
    );
  }
}
