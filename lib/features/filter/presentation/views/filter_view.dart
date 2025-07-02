import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/widgets/brand_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/car_type_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_footer_buttons.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_header.dart';
import 'package:x_go/features/filter/presentation/widgets/price_range_labels.dart';
import 'package:x_go/features/filter/presentation/widgets/price_slider.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? selectedBrand;
  String? selectedFuelType;
  RangeValues? selectedRange; // Nullable now

  void _resetFilters() {
    setState(() {
      selectedBrand = null;
      selectedFuelType = null;
      selectedRange = null;
    });
  }

  void _applyFilters() {
    final double? minPrice = selectedRange != null ? selectedRange!.start * 10 : null;
    final double? maxPrice = selectedRange != null ? selectedRange!.end * 10 : null;

    // إرسال البيانات إلى HomeCubit
    context.read<HomeCubit>().getHomeData(
          minPrice,
          maxPrice,
          selectedBrand,
          selectedFuelType,
        );

    // إغلاق شاشة الفلترة
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
                    if (selectedBrand == brand) {
                      selectedBrand = null; // إلغاء التحديد إذا تم الضغط على البراند المحدد
                    } else {
                      selectedBrand = brand;
                    }
                  });
                },
              ),
              Divider(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                thickness: 1,
              ),
              const SizedBox(height: 24),
              PriceSlider(
                rangeValues: selectedRange ?? const RangeValues(4, 12),
                onChanged: (newRange) {
                  setState(() {
                    if (newRange.start == 4 && newRange.end == 12) {
                      selectedRange = null; // إلغاء التحديد إذا النطاق الافتراضي
                    } else {
                      selectedRange = newRange;
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              PriceRangeLabels(rangeValues: selectedRange ?? const RangeValues(4, 12)),
              const SizedBox(height: 24),
              FuelTypeSelector(
                selectedFuelType: selectedFuelType,
                onFuelTypeSelected: (type) {
                  setState(() {
                    if (selectedFuelType == type) {
                      selectedFuelType = null; // إلغاء التحديد
                    } else {
                      selectedFuelType = type;
                    }
                  });
                },
              ),
              const SizedBox(height: 30),
              FilterFooterButtons(
                onPressed: _resetFilters,
                onApply: _applyFilters,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
