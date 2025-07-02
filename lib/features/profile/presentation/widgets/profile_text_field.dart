// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:x_go/core/theme/app_colors.dart';

// class ProfileTextField extends StatelessWidget {
//   const ProfileTextField({super.key, required this.label, required this.controller, this.keyboardType});
//   final String label;
//   final TextEditingController controller;
//   final TextInputType? keyboardType;
 
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//           decoration: InputDecoration(
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 8.h),
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter $label';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }


//   }
