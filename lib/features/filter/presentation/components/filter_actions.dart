// filter_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/components/filter_logic.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'filter_state_manager.dart';

class FilterActions {
  final BuildContext context;
  final FilterStateManager stateManager;
  final Function(FilterStateManager) onStateChanged;
  final Function(HomeRequestParams)? onFilterApplied;

  FilterActions({
    required this.context,
    required this.stateManager,
    required this.onStateChanged,
    this.onFilterApplied,
  });

  void restoreLastFilter() {
    FilterLogic.restoreLastFilter(
      context,
          (brand) => _updateState(selectedBrand: brand),
          (type) => _updateState(selectedType: type),
          (range) => _updateState(selectedRange: range),
    );
  }

  void resetFilters() {
    FilterLogic.resetFilters(
          (brand) => _updateState(selectedBrand: brand),
          (type) => _updateState(selectedType: type),
          (range) => _updateState(selectedRange: range),
    );

    final params = HomeRequestParams(page: 1);
    context.read<HomeCubit>().clearFilter();
    onFilterApplied?.call(params);
  }

  void applyFilters() {
    final params = FilterLogic.createFilterParams(
      brand: stateManager.selectedBrand,
      type: stateManager.selectedType,
      range: stateManager.selectedRange,
    );

    FilterLogic.applyFilter(
      context,
      brand: stateManager.selectedBrand,
      type: stateManager.selectedType,
      range: stateManager.selectedRange,
    );

    onFilterApplied?.call(params);
    Navigator.pop(context);
  }

  Future<void> refreshFilterData() async {
    context.read<HomeCubit>().refreshFilterInfo();
  }

  void _updateState({
    String? selectedBrand,
    String? selectedType,
    RangeValues? selectedRange,
  }) {
    final newState = stateManager.copyWith(
      selectedBrand: selectedBrand,
      selectedType: selectedType,
      selectedRange: selectedRange,
    );
    onStateChanged(newState);
  }
}
