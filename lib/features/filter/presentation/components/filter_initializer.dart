// filter_initializer.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import 'filter_state_manager.dart';

class FilterInitializer extends StatefulWidget {
  final Function(FilterStateManager) onStateChanged;
  final Widget child;

  const FilterInitializer({
    super.key,
    required this.onStateChanged,
    required this.child,
  });

  @override
  State<FilterInitializer> createState() => _FilterInitializerState();
}

class _FilterInitializerState extends State<FilterInitializer> {
  late FilterStateManager _stateManager;

  @override
  void initState() {
    super.initState();
    _stateManager = FilterStateManager();
    _initializeFilterData();
  }

  void _initializeFilterData() {
    final cubit = context.read<HomeCubit>();

    if (cubit.cachedFilterInfo != null) {
      _stateManager = _stateManager.copyWith(
        cachedBrands: cubit.cachedFilterInfo!.brands,
        cachedTypes: cubit.cachedFilterInfo!.types,
        hasLoadedData: true,
      );
      widget.onStateChanged(_stateManager);
      cubit.emit(FilterInfoLoaded(filterInfo: cubit.cachedFilterInfo!));
    } else {
      cubit.getFilterInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
