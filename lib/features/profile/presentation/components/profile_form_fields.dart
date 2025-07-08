import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';

class ProfileFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const ProfileFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // First and Last Name
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'First Name',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      hintText: 'First Name',
                      fillColor: Colors.white,
                      controller: firstNameController,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Last Name',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      hintText: 'Last Name',
                      fillColor: Colors.white,
                      controller: lastNameController,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 30.h),

          // Email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                hintText: 'Email',
                controller: emailController,
                fillColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),

          SizedBox(height: 30.h),

          // Phone
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Phone',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                hintText: 'Phone',
                fillColor: Colors.white,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
