// features/Details/presentation/widgets/car_info_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class CarInfoSection extends StatelessWidget {
  final CarEntity car;

  const CarInfoSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الصف الأول
        Row(
          children: [
            Expanded(
              child: InfoCard(
                title: 'السنة',
                value: car.year,
                icon: Icons.calendar_today,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: InfoCard(
                title: 'النوع',
                value: car.typeName,
                icon: Icons.directions_car,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: InfoCard(
                title: 'المحرك',
                value: car.engineType,
                icon: Icons.settings,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // الصف الثاني
        Row(
          children: [
            Expanded(
              child: InfoCard(
                title: 'ناقل الحركة',
                value: car.transmissionType,
                icon: Icons.sync,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: InfoCard(
                title: 'نوع المقاعد',
                value: car.seatType,
                icon: Icons.airline_seat_recline_normal,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: InfoCard(
                title: 'عدد المقاعد',
                value: '${car.seatsCount}',
                icon: Icons.people,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // الصف الثالث
        Row(
          children: [
            Expanded(
              child: InfoCard(
                title: 'التسارع',
                value: '${car.acceleration}s',
                icon: Icons.speed,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: InfoCard(
                title: 'السعر/يوم',
                value: '${car.price} ج',
                icon: Icons.attach_money,
              ),
            ),
            SizedBox(width: 8.w),
            // مساحة فارغة للتوازن
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24.sp, color: AppColors.primaryColor),
            SizedBox(height: 6.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
