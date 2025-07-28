// features/home/presentation/components/cars_list_component.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/app_cubit/guest_mode/enums.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/client/features/Details/presentation/logic/cubit/car_detail_cubit.dart';
import 'package:x_go/client/features/Details/presentation/views/car_detail_view.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_cubit.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_state.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import 'package:x_go/client/features/home/presentation/components/Cars_loading_states.dart';
import '../logic/cubit/home_cubit/home_cubit.dart';
import '../logic/cubit/home_cubit/home_state.dart';
import '../widgets/car_card_widget.dart';
import 'cars_error_status.dart';
import 'cars_empty_status.dart';

class CarsListComponent extends StatefulWidget {
  final HomeRequestParams? currentParams;
  final bool isGrid;

  const CarsListComponent({
    super.key,
    this.currentParams,
    required this.isGrid,
  });

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
    final sessionState = context.read<SessionCubit>().state;
    final isGuest = sessionState.status == AuthStatus.guest;
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
                      child: BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFavorite = context
                              .read<FavoritesCubit>()
                              .isFavorite(car.id);
                          return CarCardWidget(
                            brand: car.brandName,
                            isGuest: isGuest, //

                            model: car.modelName,
                            rentPrice: car.price,
                            imageUrl: car.image,
                            carId: car.id,

                            isGridView: true,
                            isFavorite: isFavorite,
                            onFavoriteToggle: () {
                              final sessionState = context
                                  .read<SessionCubit>()
                                  .state;

                              final isGuest =
                                  sessionState.status == AuthStatus.guest;
                              if (isGuest) {
                                showToast(
                                  message: 'يجب تسجيل الدخول أولاً',
                                  state: ToastStates.ERROR,
                                );
                                return;
                              }

                              context.read<FavoritesCubit>().toggleFavorite(
                                car.id,
                              );
                            },
                          );
                        },
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
                        child: BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, state) {
                            final isFavorite = context
                                .read<FavoritesCubit>()
                                .isFavorite(car.id);
                            return CarCardWidget(
                              brand: car.brandName,
                              model: car.modelName,
                              isGuest: isGuest,

                              rentPrice: car.price,
                              imageUrl: car.image,
                              carId: car.id,
                              isGridView: false,
                              isFavorite: isFavorite,
                              onFavoriteToggle: () {
                                context.read<FavoritesCubit>().toggleFavorite(
                                  car.id,
                                );
                              },
                            );
                          },
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
        pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
          create: (context) => getIt<CarDetailCubit>(),
          child: CarDetailsPage(carId: car.id),
        ),
      ),
    );
  }
}
