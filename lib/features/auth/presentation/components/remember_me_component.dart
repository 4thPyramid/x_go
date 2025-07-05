import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Text(
              'Remember me',
              style: AppStyles.ts16W400.copyWith(fontSize: 13.sp),
            ),
          ],
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            context.push(RouterNames.forgotPassword);
          },
          child: Text(
            'Forgot Password?',
            style: AppStyles.ts16W400.copyWith(fontSize: 13.sp),
          ),
        ),
      ],
    );
  }
}
