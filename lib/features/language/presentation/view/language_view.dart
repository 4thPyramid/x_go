import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_item.dart';

class LanguageDropdownTile extends StatefulWidget {
  const LanguageDropdownTile({super.key});

  @override
  State<LanguageDropdownTile> createState() => _LanguageDropdownTileState();
}

class _LanguageDropdownTileState extends State<LanguageDropdownTile> {
  final List<Map<String, String>> _languages = [
    {'name': 'English', 'code': 'en', 'flag': '🇺🇸'},
    {'name': 'العربية', 'code': 'ar', 'flag': '🇸🇦'},
    {'name': 'Русский', 'code': 'ru', 'flag': '🇷🇺'},
  ];

  late String _selectedCode;

  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedCode = context.locale.languageCode;
  }

  Future<void> _changeLanguage(String code) async {
    final newLocale = Locale(code);
    await CacheHelper.saveLanguageCode(code);
    await context.setLocale(newLocale);
    setState(() {
      _selectedCode = code;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.languageChanged.tr(
              args: [
                _languages.firstWhere((lang) => lang['code'] == code)['name']!,
              ],
            ),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileItemTile(
      title: AppStrings.language.tr(),
      icon: Icons.language,
      showTrailing: true,
    );
  }
}
