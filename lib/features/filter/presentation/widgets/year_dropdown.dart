// year_dropdown.dart
import 'package:flutter/material.dart';

class YearDropdown extends StatelessWidget {
  final List<String> years;
  final String? selectedYear;
  final Function(String?) onYearSelected;

  const YearDropdown({
    super.key,
    required this.years,
    required this.selectedYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (years.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد سنوات متاحة',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'سنة الصنع',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedYear,
              hint: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'اختر سنة الصنع',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('كل السنوات'),
                ),
                ...years.map((year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
              ],
              onChanged: onYearSelected,
            ),
          ),
        ),
      ],
    );
  }
}
