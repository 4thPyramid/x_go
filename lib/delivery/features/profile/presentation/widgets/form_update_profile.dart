import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/update_profile/update_profile_cubit.dart';
import 'package:x_go/delivery/features/profile/presentation/views/profile_update_view.dart';
import 'package:x_go/delivery/features/profile/presentation/widgets/custom_Input_profiel_field.dart';

Widget buildForm(BuildContext context, UpdateProfileCubit cubit) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.r),
    child: Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, size: 50.sp, color: AppColors.grey),
            ),
          ),
          SizedBox(height: 30.h),

          buildInputField(
            controller: cubit.nameController,
            label: 'الاسم',
            hint: 'أدخل الاسم الكامل',
            icon: Icons.person_outline,
            validator: (value) =>
                value == null || value.isEmpty ? 'الرجاء إدخال الاسم' : null,
          ),
          SizedBox(height: 20.h),

          buildInputField(
            controller: cubit.emailController,
            label: 'البريد الإلكتروني',
            hint: 'أدخل البريد الإلكتروني',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value == null || value.isEmpty
                ? 'الرجاء إدخال البريد الإلكتروني'
                : null,
          ),
          SizedBox(height: 20.h),

          buildInputField(
            controller: cubit.phoneController,
            label: 'رقم الهاتف',
            hint: 'أدخل رقم الهاتف',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.isEmpty
                ? 'الرجاء إدخال رقم الهاتف'
                : null,
          ),
          SizedBox(height: 40.h),

          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: cubit.isLoading
                  ? null
                  : () => submitForm(context, cubit),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                disabledBackgroundColor: AppColors.grey.withOpacity(0.5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: cubit.isLoading
                  ? CircularProgressIndicator(color: AppColors.white)
                  : Text(
                      'تحديث البيانات',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}
