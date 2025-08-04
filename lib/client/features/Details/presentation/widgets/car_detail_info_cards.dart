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
      childAspectRatio: 2.2, // زيادة النسبة أكثر لمنع الـ overflow
      children: [
        _buildInfoCard('Year', attributes.year, Icons.calendar_today_rounded),
        _buildInfoCard(
          'Engine',
          attributes.engineType,
          Icons.local_gas_station_rounded,
        ),
        _buildInfoCard(
          'Transmission',
          attributes.transmissionType,
          Icons.settings_applications_rounded,
        ),
        _buildInfoCard(
          'Seats',
          '${attributes.seatsCount} Seats',
          Icons.event_seat_rounded,
        ),
        _buildInfoCard('Seat Type', attributes.seatType, Icons.chair_rounded),
        _buildInfoCard(
          'Acceleration',
          '${attributes.acceleration}s',
          Icons.speed_rounded,
        ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBorderGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w), // تقليل الـ padding أكثر
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Icon Container
            Container(
              padding: EdgeInsets.all(4.w), // تقليل padding الأيقونة أكثر
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                icon,
                size: 16.r, // تقليل حجم الأيقونة أكثر
                color: AppColors.primaryColor,
              ),
            ),

            // Label and Value in expanded space
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Label
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 9.sp, // تقليل حجم الخط أكثر
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 1.h), // تقليل المسافة أكثر
                  // Value
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 10.sp, // تقليل حجم الخط أكثر
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.1,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
