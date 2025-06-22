import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/menu.png', height: 50.h),
        Spacer(),
        Row(
          children: [
            Text('Cairo,Egypt'),
            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
        Spacer(),
        CircleAvatar(),
      ],
    );
  }
}
