// features/home/presentation/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/presentation/components/car_component.dart';
import 'package:x_go/features/home/presentation/components/custom_cursor_slider.dart';
import 'package:x_go/features/language/presentation/widgets/instant_language_builder.dart';
import '../components/header_component.dart';
import '../components/popular_cars_component.dart';
import '../components/search_component.dart';
import '../logic/cubit/home_cubit/home_cubit.dart';
import '../logic/cubit/home_cubit/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  HomeRequestParams? _currentParams;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<HomeCubit>();
      final currentState = cubit.state;
      if (currentState is HomeInitial || currentState is HomeError) {
        cubit.getCars();
      }
    });
  }

  void _updateParams(HomeRequestParams params) {
    _currentParams = params;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RealTimeLanguageBuilder(
        builder: (context, locale) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  const HeaderComponent(),
                  SizedBox(height: 2.h),
                  SearchComponent(onParamsChanged: _updateParams),
                  SizedBox(height: 4.h),
                  const CustomCursorSlider(),
                  const PopularCarsComponent(),
                  Expanded(
                    child: CarsListComponent(currentParams: _currentParams),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
