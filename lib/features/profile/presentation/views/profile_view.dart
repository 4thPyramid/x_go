import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_item.dart';
import 'package:x_go/features/profile/presentation/widgets/user_card_info.dart';
import '../widgets/profile_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF7F7F7),
    body: SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
                child: Container(
                  height: 126.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xffE6911E)),
                  child: Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30.h,
                left: 17.w,
                right: 17.w,
                child: const UserInfoCard(
                  name: 'Ahmed Elsayed',
                  location: 'Cairo, Egypt',
                  imageUrl: 'https://via.placeholder.com/150',
                ),
              ),
            ],
          ),
          const SizedBox(height: 100), // تعويض المسافة بين الهيدر والكونتنت
          const ProfileSection(
            title: 'Profile Details',
            items: [
              ProfileItemTile(title: 'My details', icon: Icons.person),
              ProfileItemTile(title: 'My Cars', icon: Icons.directions_car),
              ProfileItemTile(title: 'Car List', icon: Icons.list),
              ProfileItemTile(title: 'Notification', isSwitch: true, icon: Icons.notifications),
            ],
          ),
          const SizedBox(height: 16),
          const ProfileSection(
            title: 'Account Setting',
            items: [
              ProfileItemTile(title: 'Payment', icon: Icons.payment),
              ProfileItemTile(title: 'Language', icon: Icons.language),
              ProfileItemTile(title: 'Help & support', icon: Icons.help_outline),
              ProfileItemTile(title: 'Add feedback', icon: Icons.feedback),
            ],
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text("Log out", style: TextStyle(color: Colors.red)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
}
