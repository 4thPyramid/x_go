// features/home/presentation/components/cars_empty_status.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarsEmptyState extends StatelessWidget {
  final bool isSearchResult;
  final String? errorMessage;

  const CarsEmptyState({
    super.key,
    this.isSearchResult = false,
    this.errorMessage,
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
            errorMessage ??
                (isSearchResult
                    ? 'لا توجد نتائج للبحث'
                    : 'لا توجد سيارات متاحة'),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          if (isSearchResult && errorMessage == null) ...[
            SizedBox(height: 8.h),
            Text(
              'جرب البحث بكلمات مختلفة',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
            ),
          ],
          if (errorMessage != null) ...[
            SizedBox(height: 8.h),
            Text(
              'تأكد من كتابة اسم السيارة أو العلامة التجارية بشكل صحيح',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
