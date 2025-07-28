// ✅ CarCardWidget بعد التعديل لمنع الجيست من الضغط على الفيفوريت
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_shimmer.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/core/utils/image_url_helper.dart';

class CarCardWidget extends StatelessWidget {
  final String brand;
  final String model;
  final String rentPrice;
  final String imageUrl;
  final bool isGridView;
  final String carId;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final bool isGuest; // ✅ مضاف

  const CarCardWidget({
    super.key,
    required this.brand,
    required this.model,
    required this.rentPrice,
    required this.imageUrl,
    required this.carId,
    this.isGridView = true,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isGridView ? _buildGridLayout(context) : _buildListLayout(context),
    );
  }

  Widget _buildGridLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: _buildImage(context),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            brand,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            model,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 26.w,
                      height: 26.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 12.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Rent price : ',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      Flexible(
                        child: Text(
                          rentPrice,
                          style: TextStyle(
                            color: Colors.orange[700],
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListLayout(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(
            width: double.infinity,
            height: 160.h,
            child: _buildImage(context),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            brand,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            model,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (onFavoriteToggle != null)
                      GestureDetector(
                        onTap: () {
                          if (isGuest) {
                            showToast(
                              message: 'يجب تسجيل الدخول أولاً',
                              state: ToastStates.ERROR,
                            );
                            return;
                          }
                          onFavoriteToggle!();
                          showToast(
                            message: isFavorite
                                ? 'Car removed from favorites'
                                : 'Car added to favorites',
                            state: isFavorite
                                ? ToastStates.WARNING
                                : ToastStates.SUCCESS,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Rent price : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Flexible(
                            child: Text(
                              rentPrice,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        if (imageUrl.isNotEmpty)
          CachedNetworkImage(
            imageUrl: ImageUrlHelper.normalizeImageUrl(imageUrl),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
              child: const Center(child: AppShimmer()),
            ),
            errorWidget: (context, url, error) {
              ImageUrlHelper.logImageError(url, error);
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[300],
                child: Icon(Icons.car_rental, size: 30.w, color: Colors.grey),
              );
            },
          )
        else
          Image.asset(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
              child: Icon(Icons.car_rental, size: 30.w, color: Colors.grey),
            ),
          ),
        if (onFavoriteToggle != null && isGridView)
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () {
                if (isGuest) {
                  showToast(
                    message: 'يجب تسجيل الدخول أولاً',
                    state: ToastStates.ERROR,
                  );
                  return;
                }
                onFavoriteToggle!();
                showToast(
                  message: isFavorite
                      ? AppStrings.carRemovedFromFavorites.tr()
                      : AppStrings.carAddedToFavorites.tr(),
                  state: isFavorite ? ToastStates.WARNING : ToastStates.SUCCESS,
                );
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
