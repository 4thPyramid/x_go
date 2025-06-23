import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';

class ForgetPasswordComponent extends StatelessWidget {
  const ForgetPasswordComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),

            Text('Remember me'),
          ],
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            context.push(RouterNames.forgotPassword);
          },
          child: Text('Forgot Password?'),
        ),
      ],
    );
  }
}
