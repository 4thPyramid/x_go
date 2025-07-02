import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/home/domain/usecase/get_car_use_case.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';
import 'package:x_go/features/home/presentation/logic/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/home_state.dart';
import '../components/cars_listview.dart';
import '../components/header_component.dart';
import '../components/search_component.dart';
import '../components/popular_cars_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  // Load cars immediately
      Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                const HeaderComponent(),
                SizedBox(height: 6.h),
                const SearchComponent(),
                SizedBox(height: 3.h),
                const PopularCarsComponent(),
                Expanded(
                  child: BlocBuilder<CarCubit, CarState>(
                    builder: (context, state) {
                      if (state is CarLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CarError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('خطأ: ${state.message}'),
                              ElevatedButton(
                                onPressed: () => context.read<CarCubit>().refresh(),
                                child: const Text('إعادة المحاولة'),
                              ),
                            ],
                          ),
                        );
                      } else if (state is CarsLoaded) {
                        return CarsListview(cars: state.cars);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
