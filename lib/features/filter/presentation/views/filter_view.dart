import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/widgets/CarTypeSelector.dart';
import 'package:x_go/features/filter/presentation/widgets/brand_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/car_type_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_footer_buttons.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_header.dart';
import 'package:x_go/features/filter/presentation/widgets/price_range_labels.dart';
import 'package:x_go/features/filter/presentation/widgets/price_slider.dart';
import 'package:x_go/features/home/domain/entity/filter_info_entity.dart';
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_state.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? selectedBrand;
  String? selectedType;
  RangeValues selectedRange = const RangeValues(4, 12);

  @override
  void initState() {
    super.initState();
    context.read<CarCubit>().getFilterInfo();
  }

  void _resetFilters() {
    context.read<CarCubit>().getCars();

    setState(() {
      selectedBrand = null;
      selectedType = null;
      selectedRange = const RangeValues(4, 12);
    });
  }

  void _applyFilters() {
    final filterRequest = FilterRequestEntity(
      brand: selectedBrand,
      type: selectedType,
      minPrice: (selectedRange.start * 1000).toInt().toString(),
      maxPrice: (selectedRange.end * 1000).toInt().toString(),
    );

    context.read<CarCubit>().applyFilter(filterRequest);
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
          child: BlocBuilder<CarCubit, CarState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FilterHeader(),
                    const SizedBox(height: 10),

                    // Brand Selector
                    _buildBrandSelector(state),

                    Divider(
                      color: const Color.fromARGB(
                        255,
                        0,
                        0,
                        0,
                      ).withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 18),

                    // Price Slider
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
                      height: MediaQuery.of(context).viewInsets.bottom > 0
                          ? 100
                          : 20,
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

  Widget _buildBrandSelector(CarState state) {
    if (state is FilterInfoLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is FilterInfoLoaded) {
      return BrandSelector(
        brands: state.filterInfo.brands,
        selectedBrand: selectedBrand,
        onBrandSelected: (brand) {
          setState(() {
            selectedBrand = brand;
          });
        },
      );
    }

    if (state is FilterInfoError) {
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
                context.read<CarCubit>().getFilterInfo();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return BrandSelector(
      brands: const [
        BrandEntity(name: 'BMW', logo: ''),
        BrandEntity(name: 'Mercedes', logo: ''),
        BrandEntity(name: 'Toyota', logo: ''),
      ],
      selectedBrand: selectedBrand,
      onBrandSelected: (brand) {
        setState(() {
          selectedBrand = brand;
        });
      },
    );
  }

  Widget _buildTypeSelector(CarState state) {
    if (state is FilterInfoLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is FilterInfoLoaded) {
      final types = state.filterInfo.types.map((type) => type.name).toList();

      return CarTypeSelector(
        types: types,
        selectedType: selectedType,
        onTypeSelected: (type) {
          setState(() {
            selectedType = type;
          });
        },
      );
    }

    if (state is FilterInfoError) {
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
                context.read<CarCubit>().getFilterInfo();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return CarTypeSelector(
      types: const ['Manual', 'Automatic', 'Hybrid'],
      selectedType: selectedType,
      onTypeSelected: (type) {
        setState(() {
          selectedType = type;
        });
      },
    );
  }
}
