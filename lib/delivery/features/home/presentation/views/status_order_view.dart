import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_tab_bar_delivery_app.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/status_order/completed_order_tab.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/status_order/with_delivery_order_tab.dart';

class StatusOrderView extends StatelessWidget {
  const StatusOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(18.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Status',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: CustomTabBarAppDelivery(
                  tabBaritem1: 'Completed Orders',
                  tabBaritem2: 'With Delivery',
                  tabBarWidget1: CompletedOrderTab(),
                  tabBarWidget2: WithDeliveryOrderTab(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
