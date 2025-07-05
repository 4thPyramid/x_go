import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:x_go/features/home/presentation/components/cars_listview.dart';
import 'package:x_go/features/home/presentation/components/header_component.dart';
import 'package:x_go/features/home/presentation/components/search_component.dart';
import 'package:x_go/features/home/presentation/components/popular_cars_component.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<CarCubit>();
      final currentState = cubit.state;
      if (currentState is CarInitial || currentState is CarError) {
        cubit.getCars();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              const HeaderComponent(),
              SizedBox(height: 8.h),
              SearchComponent(),
              SizedBox(height: 4.h),
              const PopularCarsComponent(),
              SizedBox(height: 8.h),
              Expanded(child: _buildCarsSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarsSection() {
    return BlocBuilder<CarCubit, CarState>(
      builder: (context, state) {
        return switch (state) {
          CarInitial() || CarLoading() => _buildLoadingState(),
          CarError() => _buildErrorState(state.message),
          CarsLoaded() => _buildLoadedState(state),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 2.0),
          SizedBox(height: 16.h),
          Text(
            'جاري التحميل...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.w, color: Colors.red[400]),
            SizedBox(height: 16.h),
            Text(
              'حدث خطأ',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => _handleRetry(),
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(CarsLoaded state) {
    final hasSearch = state.searchQuery?.isNotEmpty ?? false;
    final cars = hasSearch ? state.filteredCars : state.cars;

    if (cars.isEmpty) {
      return _buildEmptyState(hasSearch);
    }

    return CarsListview(cars: cars);
  }

  Widget _buildEmptyState(bool isSearchResult) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearchResult ? Icons.search_off : Icons.directions_car_outlined,
            size: 48.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            isSearchResult ? 'لا توجد نتائج للبحث' : 'لا توجد سيارات متاحة',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          if (isSearchResult) ...[
            SizedBox(height: 8.h),
            Text(
              'جرب البحث بكلمات مختلفة',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[500],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _handleRetry() {
    context.read<CarCubit>().refresh();
  }
}