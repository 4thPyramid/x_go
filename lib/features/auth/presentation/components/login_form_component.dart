import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/functions/validator.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/auth/presentation/components/remember_me_component.dart';
import 'package:x_go/features/auth/presentation/logic/cubit/auth_cubit.dart';
import 'package:x_go/features/splash/views/splash_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isRememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isGuest = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(
              controller: _emailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: Validator.validateEmail,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              controller: _passwordController,

              labelText: 'Password',
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
            SizedBox(height: 24.h),
            RememberMeComponent(
              onChanged: (value) {
                setState(() {
                  _isRememberMe = value;
                });
              },
            ),
            SizedBox(height: 16.h),
            BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                return state is LoginLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'Login',
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AuthCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                              _isRememberMe,
                            );
                          }
                        },
                      );
              },
              listener: (BuildContext context, AuthState state) {
                if (state is LoginSuccess) {
                  context.push(RouterNames.app);
                } else if (state is LoginError) {
                  showToast(message: state.message, state: ToastStates.ERROR);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
