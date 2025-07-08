import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/widgets/CarTypeSelector.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import '../widgets/filter_header.dart';
import '../widgets/brand_selector.dart';
import '../widgets/price_slider.dart';
import '../widgets/price_range_labels.dart';
import '../widgets/filter_footer_buttons.dart';

class FilterView extends StatefulWidget {
  final Function(HomeRequestParams)? onFilterApplied;

  const FilterView({super.key, this.onFilterApplied});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? selectedBrand;
  String? selectedType;
  RangeValues selectedRange = const RangeValues(4, 12);

  List<Brand> _cachedBrands = [];
  List<CarType> _cachedTypes = [];
  bool _hasLoadedData = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getFilterInfo();
    _restoreLastFilter();
  }

  void _restoreLastFilter() {
    // استرجع آخر فلتر محفوظ من الكيوبت
    final lastFilter = context.read<HomeCubit>().lastAppliedFilter;
    if (lastFilter != null) {
      selectedBrand = lastFilter.brand;
      selectedType = lastFilter.type;
      if (lastFilter.minPrice != null || lastFilter.maxPrice != null) {
        final minPrice = double.tryParse(lastFilter.minPrice ?? '4000') ?? 4000;
        final maxPrice = double.tryParse(lastFilter.maxPrice ?? '12000') ?? 12000;
        selectedRange = RangeValues(minPrice / 1000, maxPrice / 1000);
      }
    }
  }

  void _resetFilters() {
    setState(() {
      selectedBrand = null;
      selectedType = null;
      selectedRange = const RangeValues(4, 12);
    });

    final params = HomeRequestParams(page: 1);
    context.read<HomeCubit>().clearFilter();
    widget.onFilterApplied?.call(params);
  }

  void _applyFilters() {
    final params = HomeRequestParams(
      page: 1,
      brand: selectedBrand,
      type: selectedType,
      minPrice: selectedRange.start != 4 ? (selectedRange.start * 1000).toInt().toString() : null,
      maxPrice: selectedRange.end != 12 ? (selectedRange.end * 1000).toInt().toString() : null,
    );

    context.read<HomeCubit>().applyFilter(
      brand: selectedBrand,
      type: selectedType,
      minPrice: selectedRange.start != 4 ? (selectedRange.start * 1000).toInt().toString() : null,
      maxPrice: selectedRange.end != 12 ? (selectedRange.end * 1000).toInt().toString() : null,
    );

    widget.onFilterApplied?.call(params);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 252, 251, 251),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is FilterInfoLoaded) {
                setState(() {
                  _cachedBrands = state.filterInfo.brands;
                  _cachedTypes = state.filterInfo.types;
                  _hasLoadedData = true;
                });
                // بعد تحميل الداتا أول مرة فقط استرجع آخر فلتر
                _restoreLastFilter();
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FilterHeader(),
                    const SizedBox(height: 10),
                    _buildBrandSelector(state),
                    Divider(
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 18),
                    PriceSlider(
                      rangeValues: selectedRange,
                      onChanged: (newRange) {
                        setState(() {
                          selectedRange = newRange;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    PriceRangeLabels(rangeValues: selectedRange),
                    const SizedBox(height: 20),
                    _buildTypeSelector(state),
                    const SizedBox(height: 25),
                    FilterFooterButtons(
                      onClearPressed: _resetFilters,
                      onApplyPressed: _applyFilters,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom > 0 ? 100 : 20,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBrandSelector(HomeState state) {
    if (state is FilterLoading && !_hasLoadedData) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is HomeError && !_hasLoadedData) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(
              'Error loading brands: ${state.message}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().getFilterInfo();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return BrandSelector(
      brands: _cachedBrands,
      selectedBrand: selectedBrand,
      onBrandSelected: (brand) {
        setState(() {
          selectedBrand = selectedBrand == brand ? null : brand;
        });
      },
    );
  }

  Widget _buildTypeSelector(HomeState state) {
    if (state is FilterLoading && !_hasLoadedData) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is HomeError && !_hasLoadedData) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(
              'Error loading types: ${state.message}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().getFilterInfo();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final types = _cachedTypes.map((type) => type.name).toList();

    return CarTypeSelector(
      types: types,
      selectedType: selectedType,
      onTypeSelected: (type) {
        setState(() {
          selectedType = selectedType == type ? null : type;
        });
      },
    );
  }
}
