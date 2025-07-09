// filter_logic.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';

class FilterLogic {
  static void restoreLastFilter(
    BuildContext context,
    Function(String?) setBrand,
    Function(String?) setType,
    Function(String?) setYear,
    Function(RangeValues) setRange,
  ) {
    final lastFilter = context.read<HomeCubit>().lastAppliedFilter;
    if (lastFilter != null) {
      setBrand(lastFilter.brand);
      setType(lastFilter.type);
      setYear(lastFilter.year);
      if (lastFilter.minPrice != null || lastFilter.maxPrice != null) {
        final minPrice = double.tryParse(lastFilter.minPrice ?? '2000') ?? 2000;
        final maxPrice = double.tryParse(lastFilter.maxPrice ?? '9000') ?? 9000;
        setRange(RangeValues(minPrice, maxPrice));
      }
    }
  }

  static void resetFilters(
    Function(String?) setBrand,
    Function(String?) setType,
    Function(String?) setYear,
    Function(RangeValues) setRange,
  ) {
    setBrand(null);
    setType(null);
    setYear(null);
    setRange(const RangeValues(2000, 9000));
  }

  static HomeRequestParams createFilterParams({
    String? brand,
    String? type,
    String? year,
    required RangeValues range,
  }) {
    return HomeRequestParams(
      page: 1,
      brand: brand,
      type: type,
      year: year,
      minPrice: range.start.round().toString(),
      maxPrice: range.end.round().toString(),
    );
  }

  static void applyFilter(
    BuildContext context, {
    String? brand,
    String? type,
    String? year,
    required RangeValues range,
  }) {
    context.read<HomeCubit>().applyFilter(
      brand: brand,
      type: type,
      year: year,
      minPrice: range.start.round().toString(),
      maxPrice: range.end.round().toString(),
    );
  }
}
