import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/profile/presentation/components/profile_form_fields.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_header.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_image.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
             buildprofileHaderSection(context),
              Padding(
               padding: EdgeInsets.symmetric(horizontal: 45.w),
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    
                   
                    ProfileFormFields(),
                    SizedBox(height: 40.h),
                                   CustomButton(text: 'Save Change', onPressed: (){}),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildprofileHaderSection(BuildContext context) {
    return  Column(
      children: [
        ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
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
              offset: Offset(0, -40), // مقدار الطلوع لأعلى
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: const ProfileImage(),
              ),
            ),
      ],
    );

            // ← User Card خارج Stack لكن ظاهر فيه جزء منه داخل الهيدر
           
            
  }
}