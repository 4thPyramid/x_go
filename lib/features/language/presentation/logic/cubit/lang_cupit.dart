import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';

class LocalizationCubit extends Cubit<Locale> {
  LocalizationCubit() : super(Locale(CacheHelper.getSavedLanguageCode()));

  Future<void> changeLanguage(Locale locale, BuildContext context) async {
    await context.setLocale(locale);
    await CacheHelper.saveLanguageCode(locale.languageCode);
    emit(locale);
  }
}
