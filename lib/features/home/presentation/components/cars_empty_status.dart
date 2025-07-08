// features/home/presentation/components/cars_empty_status.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarsEmptyState extends StatelessWidget {
  final bool isSearchResult;

  const CarsEmptyState({
    super.key,
    this.isSearchResult = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearchResult ? Icons.search_off : Icons.directions_car_outlined,
            size: 48.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            isSearchResult ? 'لا توجد نتائج للبحث' : 'لا توجد سيارات متاحة',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          if (isSearchResult) ...[
            SizedBox(height: 8.h),
            Text(
              'جرب البحث بكلمات مختلفة',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[500],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
