// filter_content.dart
import 'package:flutter/material.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import '../widgets/filter_header.dart';
import '../widgets/price_slider.dart';
import '../widgets/price_range_labels.dart';
import '../widgets/filter_footer_buttons.dart';
import 'filter_brand_section.dart';
import 'filter_type_section.dart';
import 'filter_year_section.dart';

class FilterContent extends StatelessWidget {
  final HomeState state;
  final List<Brand> cachedBrands;
  final List<CarType> cachedTypes;
  final List<String> cachedYears;
  final bool hasLoadedData;
  final String? selectedBrand;
  final String? selectedType;
  final String? selectedYear;
  final RangeValues selectedRange;
  final Function(String?) onBrandSelected;
  final Function(String?) onTypeSelected;
  final Function(String?) onYearSelected;
  final Function(RangeValues) onRangeChanged;
  final VoidCallback onClearPressed;
  final VoidCallback onApplyPressed;
  final double? minPrice;
  final double? maxPrice;

  const FilterContent({
    super.key,
    required this.state,
    required this.cachedBrands,
    required this.cachedTypes,
    required this.cachedYears,
    required this.hasLoadedData,
    required this.selectedBrand,
    required this.selectedType,
    required this.selectedYear,
    required this.selectedRange,
    required this.onBrandSelected,
    required this.onTypeSelected,
    required this.onYearSelected,
    required this.onRangeChanged,
    required this.onClearPressed,
    required this.onApplyPressed,
    this.minPrice,
    this.maxPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FilterHeader(),
          const SizedBox(height: 10),
          FilterBrandSection(
            state: state,
            cachedBrands: cachedBrands,
            hasLoadedData: hasLoadedData,
            selectedBrand: selectedBrand,
            onBrandSelected: onBrandSelected,
          ),
          Divider(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            thickness: 1,
          ),
          const SizedBox(height: 18),
          PriceSlider(
            rangeValues: selectedRange,
            onChanged: onRangeChanged,
            minPrice: minPrice ?? 2000,
            maxPrice: maxPrice ?? 9000,
          ),
          const SizedBox(height: 10),
          PriceRangeLabels(rangeValues: selectedRange),
          const SizedBox(height: 20),
          FilterTypeSection(
            state: state,
            cachedTypes: cachedTypes,
            hasLoadedData: hasLoadedData,
            selectedType: selectedType,
            onTypeSelected: onTypeSelected,
          ),
          const SizedBox(height: 18),
          Divider(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            thickness: 1,
          ),
          const SizedBox(height: 18),
          FilterYearSection(
            state: state,
            cachedYears: cachedYears,
            hasLoadedData: hasLoadedData,
            selectedYear: selectedYear,
            onYearSelected: onYearSelected,
          ),
          const SizedBox(height: 25),
          FilterFooterButtons(
            onClearPressed: onClearPressed,
            onApplyPressed: onApplyPressed,
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom > 0 ? 100 : 20,
          ),
        ],
      ),
    );
  }
}
