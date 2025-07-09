import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileHeader extends StatelessWidget {
  final Widget? icon;
  final Widget? leadingIcon;
  const CustomProfileHeader({super.key, this.icon, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          icon ?? const SizedBox(width: 45),
          const Spacer(),
          Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          leadingIcon ?? const SizedBox(width: 45),
        ],
      ),
    );
  }
}
