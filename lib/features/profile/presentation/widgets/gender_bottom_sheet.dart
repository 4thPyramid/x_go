import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderBottomSheet {
 static  Future<void> showGenderBottomSheet({
  required BuildContext context,
  required String selectedGender,
  required Function(String gender) onGenderSelected,
}) {
  final List<String> genderOptions = ['Male', 'Female'];

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Gender",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            ...genderOptions.map((gender) {
              return ListTile(
                title: Text(gender),
                trailing: selectedGender == gender
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  onGenderSelected(gender);
                  Navigator.pop(context);
                },
              );
            })
          ],
        ),
      );
    },
  );
}
}