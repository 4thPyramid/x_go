// status_order_view.dart
// This widget displays the status of orders in the delivery app, allowing users to view accepted and completed orders.
// It uses a custom tab bar to switch between the two tabs.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_tab_bar_delivery_app.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/status_order/completed_order_tab.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/status_order/accepted_order_tab.dart';

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
                  tabBaritem2: 'Completed Orders',
                  tabBaritem1: 'Accepted Orders',
                  tabBarWidget2: CompletedOrderTab(),
                  tabBarWidget1: AcceptedOrderTab(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
