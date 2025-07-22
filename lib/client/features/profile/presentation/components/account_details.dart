import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/language/presentation/view/language_view.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_section.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
        return ProfileSection(
          title: AppStrings.accountSetting.tr(),
          items: [
            const LanguageDropdownTile(),
            ProfileItemTile(
              title: AppStrings.helpSupport.tr(),
              icon: Icons.help_outline,
            ),
            ProfileItemTile(
              title: AppStrings.addFeedback.tr(),
              icon: Icons.feedback,
            ),
            ProfileItemTile(
              title: 'Track location',
              icon: Icons.local_car_wash_outlined,
              onTap: () {
                context.go(RouterNames.clientTrackLocation);
              },
            ),
            ProfileItemTile(
              title: AppStrings.logout.tr(),
              icon: Icons.logout,
              showTrailing: false,
              titleStyle: const TextStyle(color: Colors.red),
              color: Colors.red,
              onTap: () {
                CacheHelper.deleteToken();
                context.go(RouterNames.splash);
              },
            ),
          ],
        );
      },
    );
  }
}
