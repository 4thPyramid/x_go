import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_info_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';
import 'package:x_go/features/home/domain/usecase/get_car_use_case.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_state.dart';

class CarCubit extends Cubit<CarState> {
  final GetCarsUseCase getCarsUseCase;
  final GetFilterInfoUseCase getFilterInfoUseCase;

  List<CarEntity> _allCars = [];
  FilterInfoEntity? _filterInfo;
  FilterRequestEntity? _currentFilter;
  String? _currentSearchQuery;

  CarCubit({
    required this.getCarsUseCase,
    required this.getFilterInfoUseCase,
  }) : super(CarInitial());

  // جلب العربيات
  Future<void> getCars({FilterRequestEntity? filterRequest}) async {
    emit(CarLoading());

    final result = await getCarsUseCase.call(filterRequest);

    result.fold(
          (error) => emit(CarError(error.message)),
          (cars) {
        _allCars = cars;
        _currentFilter = filterRequest;

        final filteredCars = _applySearch(cars);

        emit(CarsLoaded(
          cars: cars,
          filteredCars: filteredCars,
          searchQuery: _currentSearchQuery,
        ));
      },
    );
  }

  void searchCars(String query) {
    if (state is CarsLoaded) {
      _currentSearchQuery = query.trim().isEmpty ? null : query.trim();

      final currentState = state as CarsLoaded;
      final filteredCars = _applySearch(currentState.cars);

      emit(currentState.copyWith(
        filteredCars: filteredCars,
        searchQuery: _currentSearchQuery,
      ));
    }
  }

  Future<void> applyFilter(FilterRequestEntity filterRequest) async {
    await getCars(filterRequest: filterRequest);
  }

  // مسح الفلتر
  Future<void> clearFilter() async {
    await getCars();
  }

  Future<void> getFilterInfo() async {
    if (_filterInfo != null) {
      emit(FilterInfoLoaded(_filterInfo!));
      return;
    }

    emit(FilterInfoLoading());

    final result = await getFilterInfoUseCase.calls();

    result.fold(
          (error) => emit(FilterInfoError(error.message)),
          (filterInfo) {
        _filterInfo = filterInfo;
        emit(FilterInfoLoaded(filterInfo));
      },
    );
  }

  List<CarEntity> _applySearch(List<CarEntity> cars) {
    if (_currentSearchQuery == null || _currentSearchQuery!.isEmpty) {
      return cars;
    }

    return cars.where((car) {
      final query = _currentSearchQuery!.toLowerCase();
      return car.name.toLowerCase().contains(query) ||
          car.brandName.toLowerCase().contains(query) ||
          car.typeName.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> refresh() async {
    await getCars(filterRequest: _currentFilter);
  }

  FilterInfoEntity? get currentFilterInfo => _filterInfo;
  FilterRequestEntity? get currentFilter => _currentFilter;
  String? get currentSearchQuery => _currentSearchQuery;
  List<CarEntity> get allCars => _allCars;
}