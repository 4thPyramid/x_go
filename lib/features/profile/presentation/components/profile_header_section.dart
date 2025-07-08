import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_header.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_image.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
          child: Container(
            height: 126.h,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: const ProfileHeader(),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -40),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: const ProfileImage(),
          ),
        ),
      ],
    );
  }
  }
