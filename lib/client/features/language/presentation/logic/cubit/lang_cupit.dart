import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(Locale(CacheHelper.getSavedLanguageCode()));

  static const List<Map<String, String>> supportedLanguages = [
    {'name': 'English', 'code': 'en', 'flag': '🇺🇸'},
    {'name': 'العربية', 'code': 'ar', 'flag': '🇸🇦'},
    {'name': 'Русский', 'code': 'ru', 'flag': '🇷🇺'},
  ];

  String get currentLanguageCode => state.languageCode;

  String get currentLanguageName {
    return supportedLanguages.firstWhere(
          (lang) => lang['code'] == currentLanguageCode,
        )['name'] ??
        'English';
  }

  String get currentLanguageFlag {
    return supportedLanguages.firstWhere(
          (lang) => lang['code'] == currentLanguageCode,
        )['flag'] ??
        '🇺🇸';
  }

  bool get isRTL => currentLanguageCode == 'ar';

  Future<void> changeLanguage(Locale locale, BuildContext context) async {
    try {
      await CacheHelper.saveLanguageCode(locale.languageCode);

      emit(locale);

      await context.setLocale(locale);
    } catch (e) {
      debugPrint('Error changing language: $e');
    }
  }

  Future<void> changeLanguageByCode(
    String languageCode,
    BuildContext context,
  ) async {
    final locale = Locale(languageCode);
    await changeLanguage(locale, context);
  }

  Future<void> toggleLanguage(BuildContext context) async {
    final currentCode = currentLanguageCode;
    String newCode;

    switch (currentCode) {
      case 'en':
        newCode = 'ar';
        break;
      case 'ar':
        newCode = 'ru';
        break;
      case 'ru':
        newCode = 'en';
        break;
      default:
        newCode = 'en';
    }
    await CacheHelper.saveLanguageCode(newCode);
    await changeLanguageByCode(newCode, context);
  }
}
