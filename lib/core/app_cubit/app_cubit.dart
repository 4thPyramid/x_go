import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/cached/cache_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
    : super(
        AppState(
          language: CacheHelper().getDataString(key: 'language') ?? "en",
          themeEnum:
              CacheHelper().getDataString(key: 'theme') == "light"
                  ? ThemeEnum.light
                  : ThemeEnum.dark,
        ),
      );

  //! ----------- Change Theme ----------- //
  void changeTheme([ThemeEnum? themeEnum]) {
    final newTheme =
        themeEnum ??
        (state.themeEnum == ThemeEnum.light ? ThemeEnum.dark : ThemeEnum.light);

    emit(state.copyWith(themeEnum: newTheme));

    CacheHelper.saveData(
      key: 'theme',
      value: newTheme == ThemeEnum.light ? "light" : "dark",
    );
  }

  //! ----------- Change BottomNavBar Selected Index ----------- //
  int bottomNavBar = 0;
  void changeBottomNavBarSelectedIndex(int index) {
    bottomNavBar = index;
    emit(state.copyWith(bottomNavBarSelectedIndex: index));
  }

  //! ----------- Change Language ----------- //
  Future<void> changeLanguage([String? value]) async {
    final newLanguage = state.language == "ar" ? "en" : "ar";

    emit(state.copyWith(language: newLanguage));

    await CacheHelper.saveData(key: 'language', value: newLanguage);
  }
}
