import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/language/presentation/logic/cubit/lang_cupit.dart';

class LanguageDropdownTile extends StatelessWidget {
  const LanguageDropdownTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        final cubit = context.read<LocalizationCubit>();

        return ListTile(
          leading: const Icon(Icons.language, color: Colors.grey),
          title: Text(AppStrings.language.tr()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cubit.currentLanguageFlag,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              Text(
                cubit.currentLanguageName,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
          onTap: () => _showLanguageDialog(context, cubit),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context, LocalizationCubit cubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.language.tr()),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: LocalizationCubit.supportedLanguages.length,
              itemBuilder: (context, index) {
                final language = LocalizationCubit.supportedLanguages[index];
                final isSelected =
                    cubit.currentLanguageCode == language['code'];

                return ListTile(
                  leading: Text(
                    language['flag']!,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(language['name']!),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () async {
                    await cubit.changeLanguageByCode(
                      language['code']!,
                      context,
                    );

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
