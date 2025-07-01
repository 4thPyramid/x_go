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
        const SizedBox(height: 10),
        Row(
          children: brands.map((brand) {
            final isSelected = selectedBrand == brand;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GestureDetector(
                  onTap: () => onBrandSelected(brand),
                  child: Column(
                    children: [
                      Container(
                        height: 90.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? Colors.black : Color( 0xFF7B7B7B),
                          )),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30.r,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.directions_car,
                                  color: isSelected ? Colors.black :  Color( 0xFF7B7B7B),),
                              ),
                            
                          
                               SizedBox(height: 4),
                      Text(brand, style:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400, color: isSelected ? Colors.black :  Color( 0xFF7B7B7B))),]),
                        ),
                      ),
                      
                    ],
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
