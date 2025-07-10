import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/features/language/presentation/widgets/instant_language_builder.dart';

class HeaderSplash extends StatelessWidget {
  const HeaderSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return InstantLanguageBuilder(
      builder: (context, locale) {
        return Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: AppStrings.your.tr(),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: AppStrings.sporty.tr(),
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  TextSpan(
                    text: AppStrings.drive.tr(),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: AppStrings.starts.tr(),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: AppStrings.here.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
