import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/usecase/get_car_use_case.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCarsUseCase getCarsUseCase;
  final GetFilterInfoUseCase getFilterInfoUseCase;

  HomeRequestParams? _lastAppliedFilter;

  final Map<String, List<CarEntity>> _searchCache = {};
  String? _lastSearchQuery;

  List<CarEntity>? _allCarsCache;

  FilterInfo? _cachedFilterInfo;
  bool _isFilterInfoLoading = false;

  HomeCubit({required this.getCarsUseCase, required this.getFilterInfoUseCase})
      : super(HomeInitial());

  HomeRequestParams? get lastAppliedFilter => _lastAppliedFilter;

  FilterInfo? get cachedFilterInfo => _cachedFilterInfo;

  Future<void> getCars({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(HomeLoading());
      _clearSearchState();
    }

    if (!isRefresh && _allCarsCache != null && _allCarsCache!.isNotEmpty) {
      final params = HomeRequestParams(page: 1);
      emit(CarsLoaded(cars: _allCarsCache!, currentParams: params));
      return;
    }

    final params = HomeRequestParams(page: 1);
    final result = await getCarsUseCase(params);

    result.fold(
          (failure) {
        emit(HomeError(message: failure.message));
      },
          (cars) {
        _allCarsCache = cars;
        emit(CarsLoaded(cars: cars, currentParams: params));
      },
    );
  }

  Future<void> loadMoreCars() async {
    final currentState = state;
    if (currentState is CarsLoaded && !currentState.hasReachedMax) {
      final nextPage = (currentState.currentParams.page ?? 1) + 1;
      final newParams = currentState.currentParams.copyWith(page: nextPage);

      final result = await getCarsUseCase(newParams);

      result.fold(
            (failure) {
          emit(HomeError(message: failure.message));
        },
            (newCars) {
          if (newCars.isEmpty) {
            emit(currentState.copyWith(hasReachedMax: true));
          } else {
            final updatedCars = [...currentState.cars, ...newCars];

            if (newParams.search?.isEmpty ?? true) {
              _allCarsCache = updatedCars;
            }

            emit(
              CarsLoaded(
                cars: updatedCars,
                currentParams: newParams,
                hasReachedMax: false,
              ),
            );
          }
        },
      );
    }
  }

  Future<void> searchCars(String query) async {
    final trimmedQuery = query.trim().toLowerCase();

    if (trimmedQuery.isEmpty) {
      _lastSearchQuery = null;
      getCars();
      return;
    }

    if (trimmedQuery.length < 1) {
      return;
    }

    if (_searchCache.containsKey(trimmedQuery)) {
      final cachedCars = _searchCache[trimmedQuery]!;

      final params = HomeRequestParams(page: 1, search: trimmedQuery);
      emit(
        CarsLoaded(
          cars: cachedCars,
          currentParams: params,
          hasReachedMax: true,
        ),
      );
      return;
    }
    if (_lastSearchQuery == trimmedQuery) {
      return;
    }

    _lastSearchQuery = trimmedQuery;

    emit(SearchLoading());

    try {
      final params = HomeRequestParams(page: 1, search: trimmedQuery);
      final result = await getCarsUseCase(params);

      result.fold(
            (failure) {
          emit(HomeError(message: failure.message));
        },
            (cars) {
          _searchCache[trimmedQuery] = cars;

          if (_searchCache.length > 15) {
            final oldestKey = _searchCache.keys.first;
            _searchCache.remove(oldestKey);
          }
          emit(
            CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true),
          );
        },
      );
    } catch (e) {
      emit(HomeError(message: 'Search failed: $e'));
    }
  }

  Future<void> getFilterInfo({bool forceRefresh = false}) async {
    if (_isFilterInfoLoading) return;
    if (_cachedFilterInfo != null && !forceRefresh) {
      emit(FilterInfoLoaded(filterInfo: _cachedFilterInfo!));
      return;
    }
    _isFilterInfoLoading = true;
    emit(FilterLoading());
    try {
      final result = await getFilterInfoUseCase(NoParams());

      result.fold(
            (failure) {
          _isFilterInfoLoading = false;
          emit(HomeError(message: failure.message));
        },
            (filterInfo) {
          _cachedFilterInfo = filterInfo;
          _isFilterInfoLoading = false;
          emit(FilterInfoLoaded(filterInfo: filterInfo));
        },
      );
    } catch (e) {
      _isFilterInfoLoading = false;
      emit(HomeError(message: 'Filter info failed: $e'));
    }
  }

  Future<void> refreshFilterInfo() => getFilterInfo(forceRefresh: true);



  Future<void> applyFilter({
    String? brand,
    String? type,
    String? model,
    String? minPrice,
    String? maxPrice,
  }) async {
    emit(FilterLoading());

    final params = HomeRequestParams(
      page: 1,
      brand: brand,
      type: type,
      model: model,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

    _lastAppliedFilter = params;
    _clearSearchState();

    final result = await getCarsUseCase(params);

    result.fold(
          (failure) {
        emit(HomeError(message: failure.message));
      },
          (cars) {
        emit(
          CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true),
        );
      },
    );
  }

  Future<void> clearFilter() async {
    _lastAppliedFilter = null;
    _clearSearchState();
    getCars(isRefresh: true);
  }


  void _clearSearchState() {
    _lastSearchQuery = null;
    _searchCache.clear();
  }

  bool get hasActiveFilters {
    final currentState = state;
    if (currentState is CarsLoaded) {
      return currentState.currentParams.hasFilters;
    }
    return false;
  }


}
