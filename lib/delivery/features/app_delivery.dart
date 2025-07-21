import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';
import 'package:x_go/delivery/features/home/presentation/views/delivery_home.dart';
import 'package:x_go/delivery/features/home/presentation/views/status_order_view.dart';

class AppDelivery extends StatefulWidget {
  const AppDelivery({super.key});

  @override
  State<AppDelivery> createState() => _AppState();
}

class _AppState extends State<AppDelivery> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> get _pages => [const DeliveryHome(), const StatusOrderView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
        return Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              color: Colors.black,
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
                unselectedItemColor: Colors.white70,
                selectedItemColor: AppColors.primaryColor,
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12.sp,
                unselectedFontSize: 12.sp,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: AppStrings.home.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outline),
                    activeIcon: Icon(Icons.add_circle_outline),
                    label: 'Show Orders',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
