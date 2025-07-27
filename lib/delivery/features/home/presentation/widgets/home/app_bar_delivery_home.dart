import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/location_service.dart';

class AppBarDeliveryHome extends StatefulWidget {
  const AppBarDeliveryHome({super.key});

  @override
  State<AppBarDeliveryHome> createState() => _AppBarDeliveryHomeState();
}

class _AppBarDeliveryHomeState extends State<AppBarDeliveryHome> {
  final LocationService _locationService = LocationService(); // ✅
  String _locationText = 'جارٍ تحديد الموقع...';

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    final location = await _locationService.getCurrentCityAndCountry();
    setState(() {
      _locationText = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
                size: 20,
              ),
              onPressed: _loadLocation, // ✅
            ),
            Text(
              _locationText,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: AppColors.primaryColor, size: 28.w),
          onPressed: () {
            context.push(RouterNames.customSearchDeliveryApp);
          },
        ),
      ],
    );
  }
}
