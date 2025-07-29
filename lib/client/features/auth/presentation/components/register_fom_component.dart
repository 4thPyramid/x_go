import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/common/functions/validator.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';
import 'package:x_go/client/features/splash/views/splash_view.dart';

class RegisterForm extends StatefulWidget {
  final int index;
  const RegisterForm({super.key, required this.index});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isGuest = false;
  }

  @override
  Widget build(BuildContext context) {
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: SizedBox(
              height: 600.h,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _firstNameController,
                            labelText: AppStrings.firstName.tr(),
                            validator: Validator.validateName,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextFormField(
                            controller: _lastNameController,
                            labelText: AppStrings.lastName.tr(),
                            validator: Validator.validateName,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: AppStrings.email.tr(),
                      keyboardType: TextInputType.emailAddress,
                      validator: Validator.validateEmail,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _phoneController,
                      labelText: AppStrings.phoneNumber.tr(),
                      keyboardType: TextInputType.phone,
                      validator: Validator.validatePhone,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: AppStrings.password.tr(),
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: Validator.validatePassword,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      labelText: AppStrings.confirmPassword.tr(),
                      obscureText: !_isConfirmPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      validator: Validator.validatePassword,
                    ),
                    SizedBox(height: 24.h),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          showToast(
                            message: state.message,
                            state: ToastStates.SUCCESS,
                          );

                          // حدّث حالة المستخدم
                          context.read<SessionCubit>().checkAuthStatus();

                          context.go(RouterNames.app);
                        } else if (state is RegisterError) {
                          showToast(
                            message: state.message,
                            state: ToastStates.ERROR,
                          );
                        }
                      },
                      builder: (context, state) {
                        return state is RegisterLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: AppStrings.register.tr(),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context.read<AuthCubit>().register(
                                      _firstNameController.text,
                                      _lastNameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _phoneController.text,
                                    );
                                  }
                                },
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
