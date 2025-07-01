import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/car_card_widget.dart';

class CarsListview extends StatelessWidget {
  const CarsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 7.h),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.push('/carDetails');
          },
          child: CarCardWidget(
            brand: 'Toyota',
            model: 'Camry',
            rentPrice: '\$100',
            imageUrl: 'assets/images/car.png',
          ),
        );
      },
    );
  }
}
