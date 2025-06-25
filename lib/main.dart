import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/app.dart';
import 'package:x_go/core/routes/app_routers.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/core/theme/app_colors.dart';
<<<<<<< HEAD
=======
import 'package:x_go/features/splash/views/splash_view.dart';
>>>>>>> 9456741c6b5aee4fb62f9c7eb64c047c2d591844

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  /// Builds the widget tree for the application.
  ///
  /// Initializes screen size configuration with `ScreenUtilInit` for responsive design.
  /// Returns a `MaterialApp` with routing configuration and a theme applied.
  /// Hides the debug banner in the top-right corner.

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
