import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';
import 'package:x_go/client/features/splash/components/form_Splash.dart';
import 'package:x_go/client/features/splash/widgets/build_splash_rich_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: AppImageView(AppAssets.splash, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              children: [buildSplashRichText(), Spacer(), formSplash(context)],
            ),
          ),
        ],
      ),
    );
  }
}
