import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

class CarInfoSection extends StatelessWidget {
  final CarEntity car;

  const CarInfoSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InfoCard(
            title: 'السنة',
            value: car.year,
            icon: Icons.calendar_today,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InfoCard(
            title: 'النوع',
            value: car.typeName,
            icon: Icons.settings,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InfoCard(
            title: 'السعر',
            value: '${car.price}ج',
            icon: Icons.attach_money,
          ),
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 17),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}