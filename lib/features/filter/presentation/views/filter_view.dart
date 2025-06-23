import 'package:flutter/material.dart';
import 'package:x_go/features/filter/presentation/widgets/brand_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/car_type_selector.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_footer_buttons.dart';
import 'package:x_go/features/filter/presentation/widgets/filter_header.dart';
import 'package:x_go/features/filter/presentation/widgets/price_range_labels.dart';
import 'package:x_go/features/filter/presentation/widgets/price_slider.dart';


class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            FilterHeader(),
         
           
            SizedBox(height: 24),
            BrandSelector(),
            SizedBox(height: 24),
            PriceSlider(),
            SizedBox(height: 12),
            PriceRangeLabels(),
            SizedBox(height: 24),
            FuelTypeSelector(),
            SizedBox(height: 30),
            FilterFooterButtons(),
          ],
        ),
      ),
    );
  }
} 



