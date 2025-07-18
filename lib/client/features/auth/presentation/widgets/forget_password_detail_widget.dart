import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';

class ForgetPasswordDetailWidget extends StatelessWidget {
  const ForgetPasswordDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Text(
                  AppStrings.forgotPassword.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                SvgPicture.asset('assets/images/key.svg'),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              AppStrings.sendingEmail.tr(),
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
            ),
          ],
        );
      },
    );
  }
}
