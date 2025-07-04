import 'package:flutter/material.dart';

import 'package:x_go/features/language/presentation/view/language_view.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_section.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: 'Account Setting',
      items: [
        ProfileItemTile(title: 'Payment', icon: Icons.payment),
        LanguageDropdownTile(),
        ProfileItemTile(title: 'Help & support', icon: Icons.help_outline),
        ProfileItemTile(title: 'Add feedback', icon: Icons.feedback),
        ProfileItemTile(
          title: 'Logout',
          icon: Icons.logout,
          showTrailing: false,
          titleStyle: TextStyle(color: Colors.red),
          color: Colors.red,
        ),
      ],
    );
  }
}
