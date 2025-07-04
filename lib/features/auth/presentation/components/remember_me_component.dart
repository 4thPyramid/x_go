import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_styles.dart';

class RememberMeComponent extends StatelessWidget {
  const RememberMeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            Text('Remember me',style: AppStyles.ts14W600,),
          ],
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            context.push(RouterNames.forgotPassword);
          },
          child: Text('Forgot Password?',
              style: AppStyles.ts13BlackW500,
          ),
        ),
      ],
    );
  }
}
