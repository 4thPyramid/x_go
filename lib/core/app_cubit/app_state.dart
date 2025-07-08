part of 'app_cubit.dart';

class AppState {
  final String language;
  final ThemeEnum themeEnum;
  final int bottomNavBarSelectedIndex;

  AppState({
    required this.language,
    required this.themeEnum,
    this.bottomNavBarSelectedIndex = 0,
  });

  AppState copyWith({
    String? language,
    ThemeEnum? themeEnum,
    int? bottomNavBarSelectedIndex,
  }) {
    return AppState(
     
      language: language ?? this.language,
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