import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/features/profile/presentation/components/profile_form_fields.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_image.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding( 
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                _buildAppBar(context),
                SizedBox(height: 40.h),
                ProfileImage(),
                SizedBox(height: 40.h),
                ProfileFormFields(),
                SizedBox(height: 40.h),
               CustomButton(text: 'Save Change', onPressed: (){}),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          GestureDetector(
          
            child: IconButton(
              onPressed: (){
                  Navigator.pop(context);
              },
              
              icon: Icon(Icons.arrow_back_ios_new),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Profile ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
            ),
          ),
          SizedBox(width: 24.w), // Balance the back button
        ],
      ),
    );
  }
}