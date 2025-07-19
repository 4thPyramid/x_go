import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/core/utils/app_styles.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';

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
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
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
                  AppStrings.rememberMe.tr(),
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
                AppStrings.forgotPassword.tr(),
                style: AppStyles.ts16W400.copyWith(fontSize: 13.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}
