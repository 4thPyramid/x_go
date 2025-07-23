import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';

class ProfileDeliveryView extends StatelessWidget {
  const ProfileDeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              height: 110.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90.r),
                  bottomRight: Radius.circular(90.r),
                ),
              ),
              child: Stack(
                children: [
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40.r,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      title: Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Delivery Driver',
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(RouterNames.deliveryLocation);
                    },
                    child: Text('Location'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
