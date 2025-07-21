import 'package:flutter/material.dart';
import 'package:x_go/core/common/widgets/custom_tab_bar.dart';
// This widget is used to create a custom tab bar for the delivery app.
// It allows users to switch between different tabs for completed orders and orders with delivery.

class CustomTabBarAppDelivery extends StatefulWidget {
  const CustomTabBarAppDelivery({
    super.key,
    required this.tabBaritem1,
    required this.tabBaritem2,
    required this.tabBarWidget1,
    required this.tabBarWidget2,
  });
  final String tabBaritem1;
  final String tabBaritem2;
  final Widget tabBarWidget1;
  final Widget tabBarWidget2;
  @override
  State<CustomTabBarAppDelivery> createState() =>
      _CustomTabBarAppDeliveryState();
}

class _CustomTabBarAppDeliveryState extends State<CustomTabBarAppDelivery>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedIndex = 0; // To track the selected tab
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabBar(
          selectedIndex: _selectedIndex,
          tabs: [
            TabItem(text: widget.tabBaritem1),
            TabItem(text: widget.tabBaritem2),
          ],
          onTabSelected: (index) {
            setState(() {
              _selectedIndex = index;
              _tabController.animateTo(index);
            });
          },
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [widget.tabBarWidget1, widget.tabBarWidget2],
          ),
        ),
      ],
    );
  }
}
