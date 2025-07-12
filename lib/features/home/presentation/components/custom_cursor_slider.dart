import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_state.dart';

class CustomCursorSlider extends StatelessWidget {
  const CustomCursorSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is CarsLoaded) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 100.0.h,
              autoPlay: true,

              autoPlayAnimationDuration: const Duration(seconds: 4),
              autoPlayCurve: Curves.fastOutSlowIn,
              aspectRatio: 10 / 4,
              viewportFraction: 0.6,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 5),
            ),
            items: state.cars.map((car) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0.r),
                      image: DecorationImage(
                        image: NetworkImage(car.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0.r),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(179),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            car.modelName,

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );
      },
    );
  }
}
