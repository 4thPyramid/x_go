import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_cubit.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';
import 'package:x_go/client/features/home/presentation/components/car_component.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_state.dart';

class PopularCarsView extends StatefulWidget {
  const PopularCarsView({super.key});

  @override
  State<PopularCarsView> createState() => _PopularCarsViewState();
}

class _PopularCarsViewState extends State<PopularCarsView> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Popular Cars'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => context.pop(),
        ),
        actions: [AppImageView(AppAssets.logo, width: 100.w, height: 30.h)],
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          color: AppColors.primaryColor,

          fontWeight: FontWeight.bold,
        ),
      ), // AppBar with title
      body: SafeArea(
        child: BlocProvider.value(
          value: getIt<FavoritesCubit>(),
          child: CarsListComponent(
            currentParams: _currentParams,
            isGrid: false,
          ),
        ),
      ),
    );
  }
}
