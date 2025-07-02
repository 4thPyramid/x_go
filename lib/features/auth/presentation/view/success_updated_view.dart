import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';

class SuccessUpdatedView extends StatelessWidget {
  const SuccessUpdatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageView(AppAssets.successUpdated, height: 100.h),
            SizedBox(height: 24.h),
            Text(
              'You are all set!',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text('Your Password has been updated'),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Sign In',
                onPressed: () {
                  context.push(RouterNames.auth, extra: 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
