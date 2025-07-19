import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_header.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_image.dart';

class ProfileHeaderSection extends StatelessWidget {
  final Widget? icon;
  const ProfileHeaderSection({super.key, this.icon});

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
            child: CustomProfileHeader(icon: icon),
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
