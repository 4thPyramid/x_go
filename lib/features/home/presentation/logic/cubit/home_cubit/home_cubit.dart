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

  HomeCubit({
    required this.getCarsUseCase,
    required this.getFilterInfoUseCase,
  }) : super(HomeInitial());

  HomeRequestParams? get lastAppliedFilter => _lastAppliedFilter;

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

            emit(CarsLoaded(
              cars: updatedCars,
              currentParams: newParams,
              hasReachedMax: false,
            ));
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
      emit(CarsLoaded(
        cars: cachedCars,
        currentParams: params,
        hasReachedMax: true,
      ));
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
          emit(CarsLoaded(
            cars: cars,
            currentParams: params,
            hasReachedMax: true,
          ));
        },
      );
    } catch (e) {
      emit(HomeError(message: 'Search failed: $e'));
    }
  }

  Future<void> getFilterInfo() async {
    final result = await getFilterInfoUseCase(NoParams());

    result.fold(
          (failure) {
        emit(HomeError(message: failure.message));
      },
          (filterInfo) {
        emit(FilterInfoLoaded(filterInfo: filterInfo));
      },
    );
  }

  Future<void> applyFilter({
    String? brand,
    String? type,
    String? model,
    String? minPrice,
    String? maxPrice,
    String? engineType,
    String? transmissionType,
    String? seatType,
    int? minSeats,
    int? maxSeats,
  }) async {
    emit(FilterLoading());

    final params = HomeRequestParams(
      page: 1,
      brand: brand,
      type: type,
      model: model,
      minPrice: minPrice,
      maxPrice: maxPrice,
      engineType: engineType,
      transmissionType: transmissionType,
      seatType: seatType,
      minSeats: minSeats,
      maxSeats: maxSeats,
    );

    _lastAppliedFilter = params;
    _clearSearchState();

    final result = await getCarsUseCase(params);

    result.fold(
          (failure) {
        emit(HomeError(message: failure.message));
      },
          (cars) {
        emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true));
      },
    );
  }

  Future<void> clearFilter() async {
    _lastAppliedFilter = null;
    _clearSearchState();
    getCars(isRefresh: true);
  }

  Future<void> combineSearchAndFilter({
    String? searchQuery,
    String? brand,
    String? type,
    String? model,
    String? minPrice,
    String? maxPrice,
    String? engineType,
    String? transmissionType,
    String? seatType,
    int? minSeats,
    int? maxSeats,
  }) async {
    emit(FilterLoading());

    final params = HomeRequestParams(
      page: 1,
      search: searchQuery?.trim().isNotEmpty == true ? searchQuery?.trim() : null,
      brand: brand,
      type: type,
      model: model,
      minPrice: minPrice,
      maxPrice: maxPrice,
      engineType: engineType,
      transmissionType: transmissionType,
      seatType: seatType,
      minSeats: minSeats,
      maxSeats: maxSeats,
    );


    if (params.hasFilters) {
      _lastAppliedFilter = params;
    }

    final result = await getCarsUseCase(params);

    result.fold(
          (failure) {
        emit(HomeError(message: failure.message));
      },
          (cars) {
        emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true));
      },
    );
  }








  void _clearSearchState() {
    _lastSearchQuery = null;
    _searchCache.clear();
    print('🧹 Search state cleared');
  }

  void clearAllCache() {
    _clearSearchState();
    _allCarsCache = null;
    _lastAppliedFilter = null;
    print('🗑️ All cache cleared');
  }

  bool get hasActiveFilters {
    final currentState = state;
    if (currentState is CarsLoaded) {
      return currentState.currentParams.hasFilters;
    }
    return false;
  }
  String get activeFiltersDescription {
    final currentState = state;
    if (currentState is CarsLoaded) {
      final params = currentState.currentParams;
      final filters = <String>[];

      if (params.search?.isNotEmpty == true) filters.add('Search: ${params.search}');
      if (params.brand?.isNotEmpty == true) filters.add('Brand: ${params.brand}');
      if (params.type?.isNotEmpty == true) filters.add('Type: ${params.type}');
      if (params.engineType?.isNotEmpty == true) filters.add('Engine: ${params.engineType}');
      if (params.transmissionType?.isNotEmpty == true) filters.add('Transmission: ${params.transmissionType}');
      if (params.seatType?.isNotEmpty == true) filters.add('Seat Type: ${params.seatType}');
      if (params.minSeats != null || params.maxSeats != null) {
        filters.add('Seats: ${params.minSeats ?? 'Any'} - ${params.maxSeats ?? 'Any'}');
      }
      if (params.minPrice?.isNotEmpty == true || params.maxPrice?.isNotEmpty == true) {
        filters.add('Price: ${params.minPrice ?? '0'} - ${params.maxPrice ?? 'Any'} EGP');
      }

      return filters.join(' | ');
    }
    return '';
  }




}
