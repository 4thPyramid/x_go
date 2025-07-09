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
      Function(RangeValues) setRange,
      ) {
    final lastFilter = context.read<HomeCubit>().lastAppliedFilter;
    if (lastFilter != null) {
      setBrand(lastFilter.brand);
      setType(lastFilter.type);
      if (lastFilter.minPrice != null || lastFilter.maxPrice != null) {
        final minPrice = double.tryParse(lastFilter.minPrice ?? '4000') ?? 4000;
        final maxPrice = double.tryParse(lastFilter.maxPrice ?? '12000') ?? 12000;
        setRange(RangeValues(minPrice / 1000, maxPrice / 1000));
      }
    }
  }

  static void resetFilters(
      Function(String?) setBrand,
      Function(String?) setType,
      Function(RangeValues) setRange,
      ) {
    setBrand(null);
    setType(null);
    setRange(const RangeValues(4, 12));
  }

  static HomeRequestParams createFilterParams({
    String? brand,
    String? type,
    required RangeValues range,
  }) {
    return HomeRequestParams(
      page: 1,
      brand: brand,
      type: type,
      minPrice: range.start != 4 ? (range.start * 1000).toInt().toString() : null,
      maxPrice: range.end != 12 ? (range.end * 1000).toInt().toString() : null,
    );
  }

  static void applyFilter(
      BuildContext context, {
        String? brand,
        String? type,
        required RangeValues range,
      }) {
    context.read<HomeCubit>().applyFilter(
      brand: brand,
      type: type,
      minPrice: range.start != 4 ? (range.start * 1000).toInt().toString() : null,
      maxPrice: range.end != 12 ? (range.end * 1000).toInt().toString() : null,
    );
  }


}
