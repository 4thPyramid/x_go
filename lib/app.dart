import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/home/presentation/view/home_view.dart';
import 'package:x_go/features/profile/presentation/views/profile_view.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  bool _hasLoadedCars = false;

  static final List<NavigationItem> _navigationItems = [
    NavigationItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      page: BlocProvider(
        create: (context) => getIt<HomeCubit>(), // إنشاء الـ Cubit وتحميل البيانات
        child: const HomeView(),
      ),
    ),
    NavigationItem(
      label: 'Profile',
      icon: Icons.person_outlined,
      activeIcon: Icons.person,
      page: const ProfilePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationItems[_currentIndex].page,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
        bottom: 8,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
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
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: _navigationItems.map((item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: Icon(item.activeIcon),
              label: item.label,
            )).toList(),
          ),
        ),
      ),
    );
  }

void _onItemTapped(int index) {
  if (index == _currentIndex) return;

  if (index == 0 && !_hasLoadedCars) {
    // Load cars data only the first time home tab is selected
    getIt<HomeCubit>().getCars();
    _hasLoadedCars = true;
  }

  setState(() => _currentIndex = index);
}

}

class NavigationItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Widget page;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.page,
  });
}
