// features/Details/presentation/widgets/car_detail_info_cards.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_model.dart';

class CarDetailInfoCards extends StatelessWidget {
  final CarDetailAttributes attributes;

  const CarDetailInfoCards({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.5,
      children: [
        _buildInfoCard(context, 'Year', attributes.year, Icons.calendar_today),
        _buildInfoCard(
          context,
          'Engine',
          attributes.engineType,
          Icons.local_gas_station,
        ),
        _buildInfoCard(
          context,
          'Transmission',
          attributes.transmissionType,
          Icons.settings,
        ),
        _buildInfoCard(
          context,
          'Seats',
          '${attributes.seatsCount} Seats',
          Icons.event_seat,
        ),
        _buildInfoCard(context, 'Seat Type', attributes.seatType, Icons.chair),
        _buildInfoCard(
          context,
          'Acceleration',
          '${attributes.acceleration}s',
          Icons.speed,
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24.sp, color: AppColors.primaryColor),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
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
}

class InfoCardData {
  final String label;
  final String value;
  final IconData icon;

  const InfoCardData({
    required this.label,
    required this.value,
    required this.icon,
  });
}
