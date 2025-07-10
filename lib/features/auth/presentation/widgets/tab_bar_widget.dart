import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/features/auth/presentation/components/login_form_component.dart';
import 'package:x_go/features/auth/presentation/components/register_fom_component.dart';
import 'package:x_go/features/language/presentation/widgets/instant_language_builder.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InstantLanguageBuilder(
      builder: (context, locale) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5.w),
                margin: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 18.sp,
                  ).copyWith(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      child: Text(
                        AppStrings.login.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        AppStrings.register.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: AppColors.primaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 500.h,
                child: TabBarView(
                  children: [LoginForm(), RegisterForm(index: 1)],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
