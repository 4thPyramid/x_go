import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../widgets/car_card_widget.dart';

class PopularCarsComponent extends StatelessWidget {
  const PopularCarsComponent({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Popular'),
            Spacer(),
            TextButton(onPressed: () {}, child: Text('View all')),
          ],
        ),
        SizedBox(
          height: 431.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      context.push('/carDetails');
                    },
                    child: CarCardWidget(
                      brand: 'Toyota',
                      model: 'Camry',
                      rentPrice: '\$100',
                      imageUrl: 'assets/images/car.png',
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
