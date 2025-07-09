// filter_state_manager.dart
import 'package:flutter/material.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class FilterStateManager {
  String? selectedBrand;
  String? selectedType;
  RangeValues selectedRange;
  List<Brand> cachedBrands;
  List<CarType> cachedTypes;
  bool hasLoadedData;

  FilterStateManager({
    this.selectedBrand,
    this.selectedType,
    this.selectedRange = const RangeValues(3, 15),
    this.cachedBrands = const [],
    this.cachedTypes = const [],
    this.hasLoadedData = false,
  });

  FilterStateManager copyWith({
    String? selectedBrand,
    String? selectedType,
    RangeValues? selectedRange,
    List<Brand>? cachedBrands,
    List<CarType>? cachedTypes,
    bool? hasLoadedData,
  }) {
    return FilterStateManager(
      selectedBrand: selectedBrand ?? this.selectedBrand,
      selectedType: selectedType ?? this.selectedType,
      selectedRange: selectedRange ?? this.selectedRange,
      cachedBrands: cachedBrands ?? this.cachedBrands,
      cachedTypes: cachedTypes ?? this.cachedTypes,
      hasLoadedData: hasLoadedData ?? this.hasLoadedData,
    );
  }

  void reset() {
    selectedBrand = null;
    selectedType = null;
    selectedRange = const RangeValues(3, 15);
  }
}
