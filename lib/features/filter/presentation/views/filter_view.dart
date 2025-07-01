import 'package:flutter/material.dart';
import 'package:x_go/features/filter/presentation/widgets/brand_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/car_type_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_footer_buttons.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_header.dart';
import 'package:x_go/features/filter/presentation/widgets/price_range_labels.dart';
import 'package:x_go/features/filter/presentation/widgets/price_slider.dart';


class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? selectedBrand;
  String? selectedFuelType;
  RangeValues selectedRange = const RangeValues(4, 12);

  void _resetFilters() {
    setState(() {
      selectedBrand = null;
      selectedRange = const RangeValues(4, 12);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 251, 251),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FilterHeader(),
              const SizedBox(height: 15),
              BrandSelector(
                brands: ['Ferrari', 'BMW', 'Mercedes'],
                selectedBrand: selectedBrand,
                onBrandSelected: (brand) {
                  setState(() {
                    selectedBrand = brand;
                  });
                },
              ),
              const SizedBox(height: 24),
              PriceSlider(
                rangeValues: selectedRange,
                onChanged: (newRange) {
                  setState(() {
                    selectedRange = newRange;
                  });
                },
              ),
              const SizedBox(height: 12),
              PriceRangeLabels(rangeValues: selectedRange),
              const SizedBox(height: 24),
              FuelTypeSelector(
               
              ),
              const SizedBox(height: 30),
              FilterFooterButtons(
              onPressed  : _resetFilters,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

