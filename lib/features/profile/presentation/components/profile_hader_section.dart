import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_profile_header.dart';
import 'package:x_go/core/theme/app_colors.dart';
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
                  imageUrl: 'https://via.placeholder.com/150',
                ),
              ),
            ),
      ],
    );

            // ← User Card خارج Stack لكن ظاهر فيه جزء منه داخل الهيدر
           
            
  }
}