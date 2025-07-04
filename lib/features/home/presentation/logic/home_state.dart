import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_info_entity.dart';

abstract class CarState {}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarsLoaded extends CarState {
  final List<CarEntity> cars;
  final List<CarEntity> filteredCars;
  final String? searchQuery;

  CarsLoaded({
    required this.cars,
    required this.filteredCars,
    this.searchQuery,
  });

  CarsLoaded copyWith({
    List<CarEntity>? cars,
    List<CarEntity>? filteredCars,
    String? searchQuery,
  }) {
    return CarsLoaded(
      cars: cars ?? this.cars,
      filteredCars: filteredCars ?? this.filteredCars,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class CarError extends CarState {
  final String message;

  CarError(this.message);
}

class FilterInfoLoading extends CarState {}

class FilterInfoLoaded extends CarState {
  final FilterInfoEntity filterInfo;

  FilterInfoLoaded(this.filterInfo);
}

class FilterInfoError extends CarState {
  final String message;

  FilterInfoError(this.message);
}
