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
  String? selectedYear;
  RangeValues selectedRange = const RangeValues(2000, 9000);

  List<Brand> _cachedBrands = [];
  List<CarType> _cachedTypes = [];
  List<String> _cachedYears = [];
  double _minPrice = 2000;
  double _maxPrice = 9000;
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
          _cachedYears = cubit.cachedFilterInfo!.years;
          _minPrice = double.tryParse(cubit.cachedFilterInfo!.minPrice) ?? 2000;
          _maxPrice = double.tryParse(cubit.cachedFilterInfo!.maxPrice) ?? 9000;
          // تحديث selectedRange ليعكس النطاق الفعلي
          if (selectedRange.start < _minPrice ||
              selectedRange.end > _maxPrice) {
            selectedRange = RangeValues(_minPrice, _maxPrice);
          }
          _hasLoadedData = true;
        });
      });
    } else {
      cubit.getFilterInfo();
    }
  }

  void _restoreLastFilter() {
    FilterLogic.restoreLastFilter(
      context,
      (brand) => setState(() => selectedBrand = brand),
      (type) => setState(() => selectedType = type),
      (year) => setState(() => selectedYear = year),
      (range) => setState(() => selectedRange = range),
    );
  }

  void _resetFilters() {
    FilterLogic.resetFilters(
      (brand) => setState(() => selectedBrand = brand),
      (type) => setState(() => selectedType = type),
      (year) => setState(() => selectedYear = year),
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
      year: selectedYear,
      range: selectedRange,
    );

    FilterLogic.applyFilter(
      context,
      brand: selectedBrand,
      type: selectedType,
      year: selectedYear,
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
                    _cachedYears = state.filterInfo.years;
                    _minPrice =
                        double.tryParse(state.filterInfo.minPrice) ?? 2000;
                    _maxPrice =
                        double.tryParse(state.filterInfo.maxPrice) ?? 9000;
                    // تحديث selectedRange ليعكس النطاق الفعلي
                    if (selectedRange.start < _minPrice ||
                        selectedRange.end > _maxPrice) {
                      selectedRange = RangeValues(_minPrice, _maxPrice);
                    }
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
              cachedYears: _cachedYears,
              hasLoadedData: _hasLoadedData,
              selectedBrand: selectedBrand,
              selectedType: selectedType,
              selectedYear: selectedYear,
              selectedRange: selectedRange,
              minPrice: _minPrice,
              maxPrice: _maxPrice,
              onBrandSelected: (brand) => setState(() => selectedBrand = brand),
              onTypeSelected: (type) => setState(() => selectedType = type),
              onYearSelected: (year) => setState(() => selectedYear = year),
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
