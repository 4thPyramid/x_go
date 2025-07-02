import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/Details/presentation/views/car_detail_view.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

import '../widgets/car_card_widget.dart';

class CarsListview extends StatelessWidget {
  final List<CarEntity> cars;

  const CarsListview({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد سيارات متاحة',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      itemCount: cars.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 7.h),
      itemBuilder: (context, index) {
        final car = cars[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarDetailsPage(car: car),
              ),
            );
          },
          child: CarCardWidget(
            brand: car.brandName,
            model: car.name,
            rentPrice: car.price,
            imageUrl: car.image,
          ),
        );
      },
    );
  }
}
