import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_styles.dart';

class RememberMeComponent extends StatefulWidget {
  final Function(bool) onChanged;
  const RememberMeComponent({super.key, required this.onChanged});

  @override
  State<RememberMeComponent> createState() => _RememberMeComponentState();
}

class _RememberMeComponentState extends State<RememberMeComponent> {
  bool isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
              value: isRememberMe,
              onChanged: (value) {
                setState(() {
                  isRememberMe = !isRememberMe;
                  widget.onChanged(isRememberMe);
                });
              },
            ),
            Checkbox(value: true, onChanged: (value) {}),
            Text('Remember me', style: AppStyles.s14),
          ],
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            context.push(RouterNames.forgotPassword);
          },
          child: Text('Forgot Password?', style: AppStyles.s13),
        ),
      ],
    );
  }
}
