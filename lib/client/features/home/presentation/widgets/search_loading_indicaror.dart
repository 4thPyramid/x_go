// features/home/presentation/widgets/search_loading_indicator.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import '../logic/cubit/home_cubit/home_cubit.dart';
import '../logic/cubit/home_cubit/home_state.dart';

class SearchLoadingIndicator extends StatelessWidget {
  const SearchLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryColor,
            ),
          );
        }

        return Icon(
          Icons.search,
          color: Colors.grey[600],
          size: 20.sp,
        );
      },
    );
  }
}
