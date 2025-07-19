// features/home/presentation/widgets/filter_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../logic/cubit/home_cubit/home_cubit.dart';
import '../logic/cubit/home_cubit/home_state.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final hasActiveFilters = context.read<HomeCubit>().hasActiveFilters;

        return Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: hasActiveFilters ? Colors.orange[700] : Colors.orange,
                size: 22.sp,
              ),
              onPressed: onPressed,
              tooltip: 'Open filters',
              splashRadius: 20.r,
            ),
            if (hasActiveFilters)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
