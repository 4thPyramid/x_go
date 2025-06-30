import 'package:flutter/material.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_styles.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({
    super.key,
    required this.onTap,
    required this.title1,
    required this.title2,
  });
  final VoidCallback onTap;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title1,
            style: AppStyles.ts15BlackW500.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              title2,
              style: AppStyles.ts18WhiteW500.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
