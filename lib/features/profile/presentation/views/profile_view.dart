import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:x_go/features/profile/presentation/components/account_details.dart';
import 'package:x_go/features/profile/presentation/components/profile_details.dart';
import 'package:x_go/features/profile/presentation/components/profile_hader_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHaderSection(),
            const ProfileDetails(),
            SizedBox(height: 16.h),
            const AccountDetails(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
