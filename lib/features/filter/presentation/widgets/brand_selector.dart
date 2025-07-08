import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class BrandSelector extends StatelessWidget {
  final List<Brand> brands;
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
        if (brands.isEmpty)
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          )
        else
          Row(
            children: brands.map((brand) {
              final isSelected = selectedBrand == brand.name;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () => onBrandSelected(brand.name),
                    child: Container(
                      height: 110.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.black,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.network(
                                brand.logo,
                                fit: BoxFit.contain,
                                width: 40.w,
                                height: 40.h,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: 40.w,
                                    height: 40.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.car_rental,
                                    size: 30.r,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Flexible(
                            child: Text(
                              brand.name,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.orange : Colors.black,
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
