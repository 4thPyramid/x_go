part of 'app_cubit.dart';

class AppState {
  final ThemeEnum themeEnum;
  final int bottomNavBarSelectedIndex;

  AppState({
    required this.themeEnum,
    this.bottomNavBarSelectedIndex = 0,
  });

  AppState copyWith({
    ThemeEnum? themeEnum,
    int? bottomNavBarSelectedIndex,
  }) {
    return AppState(
      themeEnum: themeEnum ?? this.themeEnum,
      bottomNavBarSelectedIndex:
          bottomNavBarSelectedIndex ?? this.bottomNavBarSelectedIndex,
    );
  }
}

enum ThemeEnum {
  light,
  dark
}