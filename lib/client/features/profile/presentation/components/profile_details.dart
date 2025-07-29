import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/client/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_section.dart';

class ProfileDetails extends StatelessWidget {
  final VoidCallback? onSettingsPressed;
  const ProfileDetails({super.key, this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
        return ProfileSection(
          title: AppStrings.profileDetails.tr(),
          items: [
            ProfileItemTile(
              title: AppStrings.profileDetails.tr(),
              icon: Icons.person,
              onTap: () async {
                          if (onSettingsPressed != null) {
                            onSettingsPressed!();
                          } else {
                            final result = await context.push(RouterNames.profileDetails);
                            if (context.mounted && result == true) {
                              context.read<ProfileEditCubit>().getProfileData();
                            }
                          }
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
