import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/widgets/CarTypeSelector.dart';
import 'package:x_go/features/filter/presentation/widgets/brand_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/car_type_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_footer_buttons.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_header.dart';
import 'package:x_go/features/filter/presentation/widgets/price_range_labels.dart';
import 'package:x_go/features/filter/presentation/widgets/price_slider.dart';
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';
import 'package:x_go/features/home/presentation/logic/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/home_state.dart';


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
      minPrice: (selectedRange.start * 100).toInt().toString(),
      maxPrice: (selectedRange.end * 100).toInt().toString(),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CarCubit, CarState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FilterHeader(),
                  const SizedBox(height: 15),

                  // Brand Selector
                  if (state is FilterInfoLoaded)
                    BrandSelector(
                      brands: state.filterInfo.brands.map((b) => b.name).toList(),
                      selectedBrand: selectedBrand,
                      onBrandSelected: (brand) {
                        setState(() {
                          selectedBrand = brand;
                        });
                      },
                    )
                  else if (state is FilterInfoLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    BrandSelector(
                      brands: const ['BMW', 'Mercedes', 'Toyota'],
                      selectedBrand: selectedBrand,
                      onBrandSelected: (brand) {
                        setState(() {
                          selectedBrand = brand;
                        });
                      },
                    ),

                  Divider(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    thickness: 1,
                  ),
                  const SizedBox(height: 24),

                  // Price Slider
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

                  // Type Selector
                  if (state is FilterInfoLoaded)
                    CarTypeSelector(
                      types: state.filterInfo.types.map((t) => t.name).toList(),
                      selectedType: selectedType,
                      onTypeSelected: (type) {
                        setState(() {
                          selectedType = type;
                        });
                      },
                    )
                  else
                    CarTypeSelector(
                      types: const ['Manual', 'Automatic', 'Hybrid'],
                      selectedType: selectedType,
                      onTypeSelected: (type) {
                        setState(() {
                          selectedType = type;
                        });
                      },
                    ),

                  const SizedBox(height: 30),
                  FilterFooterButtons(
                    onClearPressed: _resetFilters,
                    onApplyPressed: _applyFilters,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



