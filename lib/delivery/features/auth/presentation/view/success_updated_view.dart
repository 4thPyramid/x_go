import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/language/presentation/logic/cubit/lang_cupit.dart';

class DeliverySuccessUpdatedView extends StatelessWidget {
  const DeliverySuccessUpdatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImageView(AppAssets.successUpdated, height: 100.h),
                SizedBox(height: 24.h),
                Text(
                  AppStrings.youAreAllSet.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(AppStrings.yourPasswordHasBeenUpdated.tr()),
                SizedBox(height: 24.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: AppStrings.login.tr(),
                    onPressed: () {
                      context.push(RouterNames.delivery, extra: 0);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
