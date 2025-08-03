import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    void pickImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Image picker functionality'),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
   return GestureDetector(
      onTap: pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 110.w,
            height: 110.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              
              
              
            ),
            child: Icon(
              Icons.person,
              size: 50.r,
              color: AppColors.primaryColor
            ),
          ),
          Positioned(
            bottom: 4.h,
            right: 4.w,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 2.w),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 14.r,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
    
  }

 
  }

    