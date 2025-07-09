// filter_state_manager.dart
import 'package:flutter/material.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class FilterStateManager {
  String? selectedBrand;
  String? selectedType;
  String? selectedYear;
  RangeValues selectedRange;
  List<Brand> cachedBrands;
  List<CarType> cachedTypes;
  List<String> cachedYears;
  bool hasLoadedData;

  FilterStateManager({
    this.selectedBrand,
    this.selectedType,
    this.selectedYear,
    this.selectedRange = const RangeValues(3, 15),
    this.cachedBrands = const [],
    this.cachedTypes = const [],
    this.cachedYears = const [],
    this.hasLoadedData = false,
  });

  FilterStateManager copyWith({
    String? selectedBrand,
    String? selectedType,
    String? selectedYear,
    RangeValues? selectedRange,
    List<Brand>? cachedBrands,
    List<CarType>? cachedTypes,
    List<String>? cachedYears,
    bool? hasLoadedData,
  }) {
    return FilterStateManager(
      selectedBrand: selectedBrand ?? this.selectedBrand,
      selectedType: selectedType ?? this.selectedType,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedRange: selectedRange ?? this.selectedRange,
      cachedBrands: cachedBrands ?? this.cachedBrands,
      cachedTypes: cachedTypes ?? this.cachedTypes,
      cachedYears: cachedYears ?? this.cachedYears,
      hasLoadedData: hasLoadedData ?? this.hasLoadedData,
    );
  }

  void reset() {
    selectedBrand = null;
    selectedType = null;
    selectedYear = null;
    selectedRange = const RangeValues(3, 15);
  }
}
