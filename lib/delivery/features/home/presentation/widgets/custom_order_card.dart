// custom_order_card.dart
// This widget displays a card for an accepted order with details like car info, image, and action button.
// It uses a cached network image for the car's image and provides a button to view order details.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderStatusEntity order;

  const OrderCard({
    super.key,
    required this.order,
    required this.statusColor,
    this.statusText,
  });
  final Color statusColor;
  final String? statusText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with car info
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.directions_car, color: Colors.blueGrey),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    '${order.modelName} - ${order.carModelYear}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    statusText ?? "No Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Full width car image
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: CachedNetworkImage(
              imageUrl: order.carModelImage,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.broken_image, size: 60.w, color: Colors.grey),
              ),
            ),
          ),

          // Footer with price and details button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to order details
              },
              icon: Icon(Icons.assignment, size: 18.w),
              label: const Text('View Details'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
