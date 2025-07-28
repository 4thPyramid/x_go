import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/app_cubit/guest_mode/enums.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/home/presentation/view/home_view.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';
import 'package:x_go/client/features/profile/presentation/views/profile_view.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/favorites/presentation/views/favorites_view.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  late final HomeCubit _homeCubit;
  late final FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
    _favoritesCubit = getIt<FavoritesCubit>();

    // Load favorites when app starts
    _favoritesCubit.getFavorites();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _favoritesCubit.close();
    super.dispose();
  }

  List<Widget> get _pages => [
    BlocProvider<HomeCubit>.value(value: _homeCubit, child: const HomeView()),
    BlocProvider<FavoritesCubit>.value(
      value: _favoritesCubit,
      child: const FavoritesView(),
    ),
    const ProfilePage(),
  ];

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
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: AppStrings.home.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline),
                    activeIcon: Icon(Icons.favorite),
                    label: AppStrings.favorites.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outlined),
                    activeIcon: Icon(Icons.person),
                    label: AppStrings.profile.tr(),
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
    final sessionState = context.read<SessionCubit>().state;

    final isGuest = sessionState.status == AuthStatus.guest;

    // تحقق عند محاولة الوصول للفيفوريت أو البروفايل
    if (isGuest && (index == 1 || index == 2)) {
      showToast(message: 'يجب تسجيل الدخول أولاً', state: ToastStates.ERROR);

      // context.pushNamed(RouterNames.auth);

      return;
    }

    if (index == 0) {
      _homeCubit.getCars();
    } else if (index == 1) {
      _favoritesCubit.getFavorites();
    }

    setState(() => _currentIndex = index);
  }
}
