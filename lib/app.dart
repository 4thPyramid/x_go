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
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  List<Widget> get _pages => [
    BlocProvider<HomeCubit>.value(
      value: _homeCubit,
      child: const HomeView(),
    ),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;

    if (index == 0) {
      _homeCubit.getCars();
    }

    setState(() => _currentIndex = index);
  }
}
