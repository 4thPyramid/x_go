import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/components/filter_container.dart';
import 'package:x_go/features/filter/presentation/components/filter_content.dart';
import 'package:x_go/features/filter/presentation/components/filter_logic.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_state.dart';

class FilterView extends StatefulWidget {
  final Function(HomeRequestParams)? onFilterApplied;

  const FilterView({super.key, this.onFilterApplied});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? selectedBrand;
  String? selectedType;
  RangeValues selectedRange = const RangeValues(3, 15);

  List<Brand> _cachedBrands = [];
  List<CarType> _cachedTypes = [];
  bool _hasLoadedData = false;

  @override
  void initState() {
    super.initState();
    _initializeFilterData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _restoreLastFilter();
    });
  }

  void _initializeFilterData() {
    final cubit = context.read<HomeCubit>();

    if (cubit.cachedFilterInfo != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _cachedBrands = cubit.cachedFilterInfo!.brands;
          _cachedTypes = cubit.cachedFilterInfo!.types;
          _hasLoadedData = true;
        });
      });
      cubit.emit(FilterInfoLoaded(filterInfo: cubit.cachedFilterInfo!));
    } else {
      cubit.getFilterInfo();
    }
  }

  void _restoreLastFilter() {
    FilterLogic.restoreLastFilter(
      context,
          (brand) => setState(() => selectedBrand = brand),
          (type) => setState(() => selectedType = type),
          (range) => setState(() => selectedRange = range),
    );
  }

  void _resetFilters() {
    FilterLogic.resetFilters(
          (brand) => setState(() => selectedBrand = brand),
          (type) => setState(() => selectedType = type),
          (range) => setState(() => selectedRange = range),
    );

    final params = HomeRequestParams(page: 1);
    context.read<HomeCubit>().clearFilter();
    widget.onFilterApplied?.call(params);
  }

  void _applyFilters() {
    final params = FilterLogic.createFilterParams(
      brand: selectedBrand,
      type: selectedType,
      range: selectedRange,
    );

    FilterLogic.applyFilter(
      context,
      brand: selectedBrand,
      type: selectedType,
      range: selectedRange,
    );

    widget.onFilterApplied?.call(params);
    Navigator.pop(context);
  }

  Future<void> _refreshFilterData() async {
    context.read<HomeCubit>().refreshFilterInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FilterContainer(
      child: RefreshIndicator(
        onRefresh: _refreshFilterData,
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is FilterInfoLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _cachedBrands = state.filterInfo.brands;
                    _cachedTypes = state.filterInfo.types;
                    _hasLoadedData = true;
                  });
                }
              });
            }
          },
          builder: (context, state) {
            return FilterContent(
              state: state,
              cachedBrands: _cachedBrands,
              cachedTypes: _cachedTypes,
              hasLoadedData: _hasLoadedData,
              selectedBrand: selectedBrand,
              selectedType: selectedType,
              selectedRange: selectedRange,
              onBrandSelected: (brand) => setState(() => selectedBrand = brand),
              onTypeSelected: (type) => setState(() => selectedType = type),
              onRangeChanged: (range) => setState(() => selectedRange = range),
              onClearPressed: _resetFilters,
              onApplyPressed: _applyFilters,
            );
          },
        ),
      ),
    );
  }
}
