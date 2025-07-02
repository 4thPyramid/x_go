import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/app.dart';
import 'package:x_go/core/routes/app_routers.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await CacheHelper.init();
  print(CacheHelper.getToken());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: ThemeData(fontFamily: 'Poppins').textTheme,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return App();
  }
}
