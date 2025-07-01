import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/features/home/presentation/components/cars_listview.dart';
import 'package:x_go/features/home/presentation/components/header_component.dart';
import 'package:x_go/features/home/presentation/components/search_component.dart';
import 'package:x_go/features/home/presentation/components/popular_cars_component.dart';
import 'package:x_go/features/home/presentation/widgets/car_card_widget.dart' show CarCardWidget;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              const HeaderComponent(),
              SizedBox(height: 8.h),
              const SearchComponent(),
              SizedBox(height: 4.h),
              const PopularCarsComponent(),
              Expanded(
                child: CarsListview()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
