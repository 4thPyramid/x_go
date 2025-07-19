import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceSlider extends StatefulWidget {
  final RangeValues rangeValues;
  final ValueChanged<RangeValues> onChanged;
  final double minPrice;
  final double maxPrice;

  const PriceSlider({
    super.key,
    required this.rangeValues,
    required this.onChanged,
    this.minPrice = 2000,
    this.maxPrice = 9000,
  });

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 2.2,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(enabled: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(10, (i) {
                final stepSize = (widget.maxPrice - widget.minPrice) / 10;
                final barValue = widget.minPrice + (i * stepSize);
                final isSelected =
                    barValue >= widget.rangeValues.start &&
                    barValue <= widget.rangeValues.end;
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: (i + 1).toDouble(),
                      width: 6,
                      borderRadius: BorderRadius.circular(4),
                      color: isSelected ? Colors.black : Colors.grey.shade400,
                    ),
                  ],
                );
              }),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        RangeSlider(
          values: widget.rangeValues,
          min: widget.minPrice,
          max: widget.maxPrice,
          divisions: ((widget.maxPrice - widget.minPrice) / 100).round(),
          activeColor: Colors.black,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
