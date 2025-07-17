import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/features/language/presentation/widgets/instant_language_builder.dart';

class ResetPasswordDetails extends StatelessWidget {
  const ResetPasswordDetails({super.key});

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
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text(
                  AppStrings.secureYourAccount.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                SvgPicture.asset('assets/images/lock.svg'),
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              AppStrings.pleaseCreateStrongPassword.tr(),
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ],
        );
      },
    );
  }
}
