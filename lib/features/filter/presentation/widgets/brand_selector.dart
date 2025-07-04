import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandSelector extends StatelessWidget {
  final List<String> brands;
  final ValueChanged<String> onBrandSelected;
  final String? selectedBrand;

  const BrandSelector({
    super.key,
    required this.brands,
    required this.onBrandSelected,
    this.selectedBrand,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Brand', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12.h),
        Row(
          children: brands.map((brand) {
            final isSelected = selectedBrand == brand;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GestureDetector(
                  onTap: () => onBrandSelected(brand),
                  child: Container(
                    height: 110.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.black : const Color(0xFF7B7B7B),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.directions_car,
                            color: isSelected ? Colors.black : const Color(0xFF7B7B7B),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Flexible(
                          child: Text(
                            brand,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.black : const Color(0xFF7B7B7B),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}