
// Future<void> filterByBrand(String brandName) async {
//   emit(FilterLoading());
//
//   final params = HomeRequestParams(page: 1, brand: brandName);
//   _lastAppliedFilter = params;
//
//   final result = await getCarsUseCase(params);
//
//   result.fold(
//         (failure) => emit(HomeError(message: failure.message)),
//         (cars) => emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true)),
//   );
// }
//
// Future<void> filterByType(String typeName) async {
//   emit(FilterLoading());
//
//   final params = HomeRequestParams(page: 1, type: typeName);
//   _lastAppliedFilter = params;
//
//   final result = await getCarsUseCase(params);
//
//   result.fold(
//         (failure) => emit(HomeError(message: failure.message)),
//         (cars) => emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true)),
//   );
// }
//
// Future<void> filterByEngineType(String engineType) async {
//   emit(FilterLoading());
//
//   final params = HomeRequestParams(page: 1, engineType: engineType);
//   _lastAppliedFilter = params;
//
//   final result = await getCarsUseCase(params);
//
//   result.fold(
//         (failure) => emit(HomeError(message: failure.message)),
//         (cars) => emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true)),
//   );
// }
//
// Future<void> filterByTransmissionType(String transmissionType) async {
//   emit(FilterLoading());
//
//   final params = HomeRequestParams(page: 1, transmissionType: transmissionType);
//   _lastAppliedFilter = params;
//
//   final result = await getCarsUseCase(params);
//
//   result.fold(
//         (failure) => emit(HomeError(message: failure.message)),
//         (cars) => emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true)),
//   );
// }
//
// Future<void> filterBySeatType(String seatType) async {
//   emit(FilterLoading());
//
//   final params = HomeRequestParams(page: 1, seatType: seatType);
//   _lastAppliedFilter = params;
//
//   final result = await getCarsUseCase(params);
//
//   result.fold(
//         (failure) => emit(HomeError(message: failure.message)),
//         (cars) => emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true)),
//   );
// }
//
// Future<void> filterBySeatsCount(int seatsCount) async {
//   emit(FilterLoading());
//
//   final params = HomeRequestParams(page: 1, minSeats: seatsCount, maxSeats: seatsCount);
//   _lastAppliedFilter = params;
//
//   final result = await getCarsUseCase(params);
//
//   result.fold(
//         (failure) => emit(HomeError(message: failure.message)),
//         (cars) => emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true)),
//   );
// }
//
// Future<void> filterByPriceRange(String minPrice, String maxPrice) async {
//   emit(FilterLoading());
//
//   final params = HomeRequestParams(page: 1, minPrice: minPrice, maxPrice: maxPrice);
//   _lastAppliedFilter = params;
//
//   final result = await getCarsUseCase(params);
//
//   result.fold(
//         (failure) => emit(HomeError(message: failure.message)),
//         (cars) => emit(CarsLoaded(cars: cars, currentParams: params, hasReachedMax: true)),
//   );
// }
//
// void getCarStatistics() {
//   final currentState = state;
//   if (currentState is CarsLoaded) {
//     final cars = currentState.cars;
//
//
//
//     final brandCounts = <String, int>{};
//     for (var car in cars) {
//       brandCounts[car.brandName] = (brandCounts[car.brandName] ?? 0) + 1;
//     }
//     print('Brands: $brandCounts');
//
//     final typeCounts = <String, int>{};
//     for (var car in cars) {
//       typeCounts[car.typeName] = (typeCounts[car.typeName] ?? 0) + 1;
//     }
//     print('Types: $typeCounts');
//
//     final engineCounts = <String, int>{};
//     for (var car in cars) {
//       engineCounts[car.engineType] = (engineCounts[car.engineType] ?? 0) + 1;
//     }
//     print('Engine types: $engineCounts');
//
//     final prices = cars.map((car) => double.tryParse(car.price) ?? 0).where((price) => price > 0);
//     if (prices.isNotEmpty) {
//       final avgPrice = prices.reduce((a, b) => a + b) / prices.length;
//       print('Average price: ${avgPrice.toStringAsFixed(2)} EGP');
//       print('Min price: ${prices.reduce((a, b) => a < b ? a : b)} EGP');
//       print('Max price: ${prices.reduce((a, b) => a > b ? a : b)} EGP');
//     }
//   }
// }
//
// bool get hasActiveFilters {
//   final currentState = state;
//   if (currentState is CarsLoaded) {
//     return currentState.currentParams.hasFilters;
//   }
//   return false;
// }
//
// String get activeFiltersDescription {
//   final currentState = state;
//   if (currentState is CarsLoaded) {
//     final params = currentState.currentParams;
//     final filters = <String>[];
//
//     if (params.search?.isNotEmpty == true) filters.add('Search: ${params.search}');
//     if (params.brand?.isNotEmpty == true) filters.add('Brand: ${params.brand}');
//     if (params.type?.isNotEmpty == true) filters.add('Type: ${params.type}');
//     if (params.engineType?.isNotEmpty == true) filters.add('Engine: ${params.engineType}');
//     if (params.transmissionType?.isNotEmpty == true) filters.add('Transmission: ${params.transmissionType}');
//     if (params.seatType?.isNotEmpty == true) filters.add('Seat Type: ${params.seatType}');
//     if (params.minSeats != null || params.maxSeats != null) {
//       filters.add('Seats: ${params.minSeats ?? 'Any'} - ${params.maxSeats ?? 'Any'}');
//     }
//     if (params.minPrice?.isNotEmpty == true || params.maxPrice?.isNotEmpty == true) {
//       filters.add('Price: ${params.minPrice ?? '0'} - ${params.maxPrice ?? 'Any'} EGP');
//     }
//
//     return filters.join(' | ');
//   }
//   return '';
// }
//
// void resetFilterState() {
//   _lastAppliedFilter = null;
// }
//
// Future<void> reapplyLastFilter() async {
//   if (_lastAppliedFilter != null) {
//     emit(FilterLoading());
//
//     final result = await getCarsUseCase(_lastAppliedFilter!);
//
//     result.fold(
//           (failure) => emit(HomeError(message: failure.message)),
//           (cars) => emit(CarsLoaded(
//         cars: cars,
//         currentParams: _lastAppliedFilter!,
//         hasReachedMax: true,
//       )),
//     );
//   } else {
//     getCars(isRefresh: true);
//   }
// }
// bool get hasLastAppliedFilter => _lastAppliedFilter != null;