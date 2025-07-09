import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_section.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: 'Profile Details',
      items: [
        ProfileItemTile(
          title: 'My details',
          icon: Icons.person,
          onTap: () {
            context.push(RouterNames.profileDetails);
          },
        ),
        ProfileItemTile(
          title: 'My Cars',
          icon: Icons.directions_car,
          onTap: () {
            context.push(RouterNames.myBooking);
          },
        ),
        ProfileItemTile(
          title: 'Notification',
          isSwitch: true,
          icon: Icons.notifications,
        ),
      ],
    );
  }
}
