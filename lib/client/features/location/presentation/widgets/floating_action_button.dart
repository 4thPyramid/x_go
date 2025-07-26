import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/location/presentation/logic/cubit/location_cubit.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200.h,
      right: 16.w,
      child: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          context.read<LocationCubit>().getCurrentLocation();
        },
        child: const Icon(Icons.my_location, color: AppColors.white),
      ),
    );
  }
}
