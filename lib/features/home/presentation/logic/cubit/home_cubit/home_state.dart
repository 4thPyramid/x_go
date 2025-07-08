import 'package:equatable/equatable.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';




abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class CarsLoaded extends HomeState {
  final List<CarEntity> cars;
  final bool hasReachedMax;
  final HomeRequestParams currentParams;

  const CarsLoaded({
    required this.cars,
    this.hasReachedMax = false,
    required this.currentParams,
  });

  CarsLoaded copyWith({
    List<CarEntity>? cars,
    bool? hasReachedMax,
    HomeRequestParams? currentParams,
  }) {
    return CarsLoaded(
      cars: cars ?? this.cars,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentParams: currentParams ?? this.currentParams,
    );
  }

  @override
  List<Object> get props => [cars, hasReachedMax, currentParams];
}

class FilterInfoLoaded extends HomeState {
  final FilterInfo filterInfo;

  const FilterInfoLoaded({required this.filterInfo});

  @override
  List<Object> get props => [filterInfo];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchLoading extends HomeState {}

class FilterLoading extends HomeState {}

class LoadingMoreCars extends HomeState {
  final List<CarEntity> cars;
  final HomeRequestParams currentParams;

  const LoadingMoreCars({
    required this.cars,
    required this.currentParams,
  });

  @override
  List<Object> get props => [cars, currentParams];
}
