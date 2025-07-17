import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_image_view.dart';
import 'package:x_go/features/favorites/data/models/favorite_model.dart';

class FavoriteCarItem extends StatelessWidget {
  final FavoriteModel favorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback? onTap;

  const FavoriteCarItem({
    super.key,
    required this.favorite,
    required this.onToggleFavorite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final car = favorite.carModel;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        margin: EdgeInsets.only(bottom: 18.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Image with Favorite Button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: AppImageView(
                    car.attributes.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ),
              ],
            ),

            // Car Details
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 27.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),

                        child: Text(
                          car.relationship.brand.brandName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 20,
                        bottom: 20,
                        child: Text(
                          '\$${car.attributes.price}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    car.relationship.modelNames.modelName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    car.attributes.year,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
