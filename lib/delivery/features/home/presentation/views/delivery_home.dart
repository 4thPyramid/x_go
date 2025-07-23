import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_tab_bar_delivery_app.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/home/app_bar_delivery_home.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/status_order/cancel_request_tab.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/status_order/new_request_tab.dart';

class DeliveryHome extends StatelessWidget {
  const DeliveryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20.w,
            vertical: 8.h,
          ),
          child: Column(
            children: [
              AppBarDeliveryHome(),
              Expanded(
                child: CustomTabBarAppDelivery(
                  tabBaritem1: 'New Orders',
                  tabBaritem2: 'Cancelled Orders',
                  tabBarWidget1: NewRequestOrderTab(),
                  tabBarWidget2: CancelOrderRequestTab(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
