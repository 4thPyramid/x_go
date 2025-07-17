// features/Details/presentation/widgets/car_detail_info_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/Details/data/models/car_detail_model.dart';

class CarDetailInfoSection extends StatelessWidget {
  final CarDetailAttributes attributes;

  const CarDetailInfoSection({Key? key, required this.attributes})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 10.h,
      childAspectRatio: 1.5,
      children: [
        _buildInfoCard(
          context,
          'Year',
          attributes.year,
          Icons.calendar_today,
          Colors.blue.shade50,
          Colors.blue,
        ),
        _buildInfoCard(
          context,
          'Engine Type',
          attributes.engineType,
          Icons.electric_car,
          Colors.green.shade50,
          Colors.green,
        ),
        _buildInfoCard(
          context,
          'Transmission',
          attributes.transmissionType,
          Icons.settings,
          Colors.purple.shade50,
          Colors.purple,
        ),
        _buildInfoCard(
          context,
          'Seats',
          '${attributes.seatsCount} Seats',
          Icons.event_seat,
          Colors.amber.shade50,
          Colors.amber.shade700,
        ),
        _buildInfoCard(
          context,
          'Seat Type',
          attributes.seatType,
          Icons.chair,
          Colors.red.shade50,
          Colors.red,
        ),
        _buildInfoCard(
          context,
          'Acceleration',
          '${attributes.acceleration} s',
          Icons.speed,
          Colors.teal.shade50,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24.sp, color: iconColor),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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

Widget _buildInfoCard(
  BuildContext context,
  String label,
  String value,
  IconData icon,
  Color bgColor,
  Color iconColor,
) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    child: Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24.sp, color: iconColor),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
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
