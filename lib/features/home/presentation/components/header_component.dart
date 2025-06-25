import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImageView(AppAssets.menu),
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
