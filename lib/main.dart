import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/core/routes/app_routers.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/language/presentation/logic/cubit/lang_cupit.dart';
import 'package:x_go/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CacheHelper.init();
  setupLocator();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(CacheHelper.getSavedLanguageCode()),
      child: BlocProvider(
        create: (context) => SessionCubit()..checkAuthStatus(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalizationCubit>(
      create: (context) => getIt<LocalizationCubit>(),
      child: BlocBuilder<LocalizationCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: (context, child) => MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              locale: locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: ThemeData(
                textTheme: ThemeData(fontFamily: 'Poppins').textTheme,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primaryColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
