import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import 'package:x_go/core/utils/image_url_helper.dart';

class CustomCursorSlider extends StatelessWidget {
  const CustomCursorSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading ||
            state is SearchLoading ||
            state is FilterLoading) {
          return _buildLoadingSlider();
        }

        if (state is CarsLoaded) {
          if (state.cars.isEmpty) {
            return _buildEmptyState();
          }

          return CarouselSlider(
            options: CarouselOptions(
              height: 110.0.h,
              autoPlay: state.cars.length > 1,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
              aspectRatio: 10 / 4,
              viewportFraction: 0.6,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 4),
              enableInfiniteScroll: state.cars.length > 1,
            ),
            items: state.cars.take(10).map((car) {
              return Builder(
                builder: (BuildContext context) {
                  return _buildCarCard(car);
                },
              );
            }).toList(),
          );
        }
        if (state is LoadingMoreCars) {
          // Show existing cars while loading more
          if (state.cars.isNotEmpty) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 110.0.h,
                autoPlay: state.cars.length > 1,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
                aspectRatio: 10 / 4,
                viewportFraction: 0.6,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 4),
                enableInfiniteScroll: state.cars.length > 1,
              ),
              items: state.cars.take(10).map((car) {
                return Builder(
                  builder: (BuildContext context) {
                    return _buildCarCard(car);
                  },
                );
              }).toList(),
            );
          }
          return _buildLoadingSlider();
        }

        if (state is HomeError) {
          return _buildErrorState(state.message);
        }

        return _buildLoadingSlider();
      },
    );
  }

  Widget _buildCarCard(dynamic car) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0.r),
        child: Stack(
          children: [
            // Background image with caching and better fallback
            Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: CachedNetworkImage(
                imageUrl: ImageUrlHelper.normalizeImageUrl(car.image),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) {
                  ImageUrlHelper.logImageError(car.image, error);
                  return _buildImagePlaceholderWithText(
                    car.modelName ?? 'Unknown Model',
                  );
                },
                // Cache settings for offline support
                useOldImageOnUrlChange: true,
                fadeInDuration: const Duration(milliseconds: 300),
                fadeOutDuration: const Duration(milliseconds: 100),
                cacheKey: car.image?.hashCode.toString(),
                memCacheWidth: 400, // Optimize memory usage
                memCacheHeight: 200,
              ),
            ),
            // Gradient overlay - always visible for text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.6),
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
            // Text content - always visible with strong background
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12.0.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                  ),
                ),
                child: Text(
                  car.modelName ?? 'Unknown Model',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 1),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholderWithText(String carName) {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: [
          // Background pattern or gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[300]!, Colors.grey[400]!],
              ),
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.directions_car, size: 30.w, color: Colors.grey[600]),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  carName,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Image cached offline',
                style: TextStyle(color: Colors.grey[500], fontSize: 8.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSlider() {
    return SizedBox(
      height: 100.0.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15.0.r),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: 2,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState([String? message]) {
    return Container(
      height: 100.0.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(15.0.r),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 24.w),
            SizedBox(height: 4.h),
            Text(
              message ?? 'Failed to load cars',
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 100.0.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15.0.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.car_rental_outlined,
              color: Colors.grey[400],
              size: 24.w,
            ),
            SizedBox(height: 4.h),
            Text(
              'No cars available',
              style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
