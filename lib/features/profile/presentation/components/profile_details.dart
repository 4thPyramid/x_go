import 'package:flutter/material.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_section.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  const ProfileSection(
            title: 'Profile Details',
            items: [
              ProfileItemTile(title: 'My details', icon: Icons.person),
              ProfileItemTile(title: 'My Cars', icon: Icons.directions_car),
              ProfileItemTile(title: 'Car List', icon: Icons.list),
              ProfileItemTile(title: 'Notification', isSwitch: true, icon: Icons.notifications),
            ],
           );
  }
}