// features/home/presentation/components/cars_list_component.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/Details/presentation/views/car_detail_view.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/presentation/components/Cars_loading_states.dart';
import '../logic/cubit/home_cubit/home_cubit.dart';
import '../logic/cubit/home_cubit/home_state.dart';
import '../widgets/car_card_widget.dart';
import 'cars_error_status.dart';
import 'cars_empty_status.dart';

class CarsListComponent extends StatefulWidget {
  final HomeRequestParams? currentParams;
  final bool isGrid;

  CarsListComponent({super.key, this.currentParams, required this.isGrid});

  @override
  State<CarsListComponent> createState() => _CarsListComponentState();
}

class _CarsListComponentState extends State<CarsListComponent> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMoreCars();
    }
  }

  void _loadMoreCars() {
    final currentState = context.read<HomeCubit>().state;
    if (currentState is CarsLoaded && !currentState.hasReachedMax) {
      setState(() {
        _isLoadingMore = true;
      });
      context.read<HomeCubit>().loadMoreCars();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is CarsLoaded || state is HomeError) {
          setState(() {
            _isLoadingMore = false;
          });
        }
      },
      builder: (context, state) {
        return switch (state) {
          HomeInitial() || HomeLoading() => const CarsLoadingState(),
          HomeError() => CarsErrorState(message: state.message),
          CarsLoaded() => _buildLoadedState(state),
          SearchLoading() => const CarsLoadingState(message: 'جاري البحث...'),
          FilterLoading() => const CarsLoadingState(
            message: 'جاري تطبيق الفلتر...',
          ),
          FilterInfoLoaded() => const SizedBox.shrink(),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildLoadedState(CarsLoaded state) {
    final cars = state.cars;

    if (cars.isEmpty) {
      return CarsEmptyState(
        isSearchResult: state.currentParams.search?.isNotEmpty ?? false,
        errorMessage: state.errorMessage,
      );
    }

    return Column(
      children: [
        Expanded(
          child: widget.isGrid == true
              ? GridView.builder(
                  controller: _scrollController,
                  itemCount: cars.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () => _navigateToDetails(context, car),
                      child: CarCardWidget(
                        brand: car.brandName,
                        model: car.modelName,
                        rentPrice: car.price,
                        imageUrl: car.image,
                        isGridView: true,
                      ),
                    );
                  },
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: cars.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () => _navigateToDetails(context, car),
                        child: CarCardWidget(
                          brand: car.brandName,
                          model: car.modelName,
                          rentPrice: car.price,
                          imageUrl: car.image,
                          isGridView: false,
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (_isLoadingMore && !state.hasReachedMax)
          const LoadingMoreIndicator(),
      ],
    );
  }

  void _navigateToDetails(BuildContext context, CarEntity car) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CarDetailsPage(car: car),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutSine;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }
}
