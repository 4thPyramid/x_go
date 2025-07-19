import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/client/features/profile/presentation/widgets/gender_bottom_sheet.dart';

class GenderFields extends StatefulWidget {
  const GenderFields({super.key});

  @override
  State<GenderFields> createState() => _GenderFieldsState();
}

class _GenderFieldsState extends State<GenderFields> {
  String _selectedGender = "Male";
  final List<String> _genderOptions = ["Male", "Female"];

  void onGenderSelected(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            GenderBottomSheet.showGenderBottomSheet(
              context: context,
              selectedGender: _selectedGender,
              onGenderSelected: onGenderSelected,
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Text(
              _selectedGender,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
