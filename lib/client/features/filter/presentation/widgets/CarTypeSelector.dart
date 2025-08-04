import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class CarTypeSelector extends StatelessWidget {
  final List<String> types;
  final String? selectedType;
  final ValueChanged<String> onTypeSelected;

  const CarTypeSelector({
    super.key,
    required this.types,
    this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              Text(
                'Car Type',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              if (selectedType != null) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    selectedType!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Car Types List
        if (types.isEmpty) _buildLoadingState() else _buildTypesList(),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBorderGrey),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'Loading types...',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypesList() {
    return SizedBox(
      height: 50.h, // Fixed height to prevent overflow
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = selectedType == type;

          return Container(
            margin: EdgeInsets.only(right: index < types.length - 1 ? 12.w : 0),
            child: _buildTypeChip(type, isSelected),
          );
        },
      ),
    );
  }

  Widget _buildTypeChip(String type, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.lightBorderGrey,
          width: isSelected ? 2.0 : 1.0,
        ),
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.white,
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          else
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTypeSelected(type),
          borderRadius: BorderRadius.circular(25.r),
          splashColor: AppColors.primaryColor.withOpacity(0.1),
          highlightColor: AppColors.primaryColor.withOpacity(0.05),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Type Icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor.withOpacity(0.15)
                        : AppColors.lightGrey.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getTypeIcon(type),
                    size: 16.r,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.textMuted,
                  ),
                ),

                SizedBox(width: 8.w),

                // Type Name
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.textPrimary,
                    letterSpacing: -0.1,
                  ),
                  child: Text(type),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    final lowerType = type.toLowerCase();
    if (lowerType.contains('suv')) {
      return Icons.local_shipping_outlined;
    } else if (lowerType.contains('sedan')) {
      return Icons.directions_car_outlined;
    } else if (lowerType.contains('hatchback')) {
      return Icons.directions_car_filled_outlined;
    } else if (lowerType.contains('coupe')) {
      return Icons.time_to_leave_outlined;
    } else if (lowerType.contains('convertible')) {
      return Icons.drive_eta_outlined;
    } else if (lowerType.contains('truck')) {
      return Icons.local_shipping;
    } else if (lowerType.contains('van')) {
      return Icons.airport_shuttle_outlined;
    } else {
      return Icons.directions_car_outlined;
    }
  }
}
