import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_header.dart';
import 'package:x_go/features/profile/presentation/widgets/user_card_info.dart';

class ProfileHaderSection extends StatelessWidget {
  const ProfileHaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                  child: Container(
                    height: 126.h,
                    width: double.infinity,
                    decoration:  BoxDecoration(color: AppColors.primaryColor),
                    child: 
                    ProfileHeader()
                  ),
                ),
                 Transform.translate(
              offset: Offset(0, -30), // مقدار الطلوع لأعلى
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: const UserInfoCard(
                  name: 'Ahmed Elsayed',
                  location: 'Cairo, Egypt',
                  imageUrl:
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                ),
              ),
            ),
      ],
    );

            // ← User Card خارج Stack لكن ظاهر فيه جزء منه داخل الهيدر
           
            
  }
}