import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceSlider extends StatefulWidget {
  final RangeValues rangeValues;
  final ValueChanged<RangeValues> onChanged;

  const PriceSlider({
    super.key,
    required this.rangeValues,
    required this.onChanged,
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
              barGroups: List.generate(16, (i) {
                final isSelected = i >= widget.rangeValues.start && i <= widget.rangeValues.end;
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
          min: 0,
          max: 15,
          divisions: 15,
          activeColor: Colors.black,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
