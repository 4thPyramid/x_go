import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/home/presentation/components/header_component.dart';
import 'package:x_go/features/home/presentation/components/search_component.dart';
import 'package:x_go/features/home/presentation/components/popular_cars_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            HeaderComponent(),
            SearchComponent(),
            PopularCarsComponent(),
          ],
        ),
      ),
    );
  }
}
