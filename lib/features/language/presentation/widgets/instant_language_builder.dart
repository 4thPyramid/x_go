import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_go/features/language/presentation/logic/cubit/lang_cupit.dart';

class InstantLanguageBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Locale locale) builder;

  const InstantLanguageBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalizationCubit, Locale>(
      listener: (context, locale) {
        context.setLocale(locale);
      },
      builder: (context, locale) {
        return KeyedSubtree(
          key: ValueKey(
            'lang_${locale.languageCode}_${DateTime.now().millisecondsSinceEpoch}',
          ),
          child: builder(context, locale),
        );
      },
    );
  }
}

class LanguageInstantWrapper extends StatelessWidget {
  final Widget child;

  const LanguageInstantWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return InstantLanguageBuilder(builder: (context, locale) => child);
  }
}
