import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/routes/router_names.dart';

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Select User Type', style: TextStyle(fontSize: 20.sp)),
            SizedBox(height: 16.h),
            CustomButton(
              text: 'client',
              onPressed: () {
                context.push(RouterNames.splash);
              },
            ),
            SizedBox(height: 16.h),
            CustomButton(
              text: 'Driver',
              onPressed: () {
                context.push(RouterNames.deliveryLocation);
              },
            ),
          ],
        ),
      ),
    );
  }
}
