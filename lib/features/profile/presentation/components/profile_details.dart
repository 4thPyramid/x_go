import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/features/language/presentation/widgets/instant_language_builder.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_section.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return InstantLanguageBuilder(
      builder: (context, locale) {
        return ProfileSection(
          title: AppStrings.profileDetails.tr(),
          items: [
            ProfileItemTile(
              title: AppStrings.profileDetails.tr(),
              icon: Icons.person,
              onTap: () {
                context.push(RouterNames.profileDetails);
              },
            ),
            ProfileItemTile(
              title: AppStrings.myCars.tr(),
              icon: Icons.directions_car,
              onTap: () {
                context.push(RouterNames.myBooking);
              },
            ),
            ProfileItemTile(
              title: AppStrings.notification.tr(),
              isSwitch: true,
              icon: Icons.notifications,
            ),
          ],
        );
      },
    );
  }
}
