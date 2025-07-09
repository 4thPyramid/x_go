// filter_view_builder.dart
import 'package:flutter/material.dart';
import 'package:x_go/features/filter/presentation/components/filter_content.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import 'filter_state_manager.dart';

class FilterViewBuilder extends StatelessWidget {
  final HomeState state;
  final FilterStateManager stateManager;
  final Function(String?) onBrandSelected;
  final Function(String?) onTypeSelected;
  final Function(RangeValues) onRangeChanged;
  final VoidCallback onClearPressed;
  final VoidCallback onApplyPressed;

  const FilterViewBuilder({
    super.key,
    required this.state,
    required this.stateManager,
    required this.onBrandSelected,
    required this.onTypeSelected,
    required this.onRangeChanged,
    required this.onClearPressed,
    required this.onApplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilterContent(
      state: state,
      cachedBrands: stateManager.cachedBrands,
      cachedTypes: stateManager.cachedTypes,
      hasLoadedData: stateManager.hasLoadedData,
      selectedBrand: stateManager.selectedBrand,
      selectedType: stateManager.selectedType,
      selectedRange: stateManager.selectedRange,
      onBrandSelected: onBrandSelected,
      onTypeSelected: onTypeSelected,
      onRangeChanged: onRangeChanged,
      onClearPressed: onClearPressed,
      onApplyPressed: onApplyPressed,
    );
  }
}
