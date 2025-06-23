import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceSlider extends StatefulWidget {
  const PriceSlider({super.key});

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  RangeValues _range = const RangeValues(4, 12);

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
                final isSelected = i >= _range.start && i <= _range.end;
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: (i + 1).toDouble(),
                      width: 8,
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
        const SizedBox(height: 12),
        RangeSlider(
          values: _range,
          min: 0,
          max: 15,
          divisions: 15,
          activeColor: Colors.black,
          onChanged: (RangeValues values) {
            setState(() {
              _range = values;
            });
          },
        ),
      ],
    );
  }
}

