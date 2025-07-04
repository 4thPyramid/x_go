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
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Text(
            'No cars available',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return ListView.separated(
      itemCount: cars.length,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 16.h), // Increased spacing
      itemBuilder: (context, index) {
        final car = cars[index];
        return InkWell(
          borderRadius: BorderRadius.circular(
            12.r,
          ), // Added ripple effect border radius
          onTap: () => _navigateToDetails(context, car),
          child: CarCardWidget(
            key: ValueKey(car.id), // Added key for better widget management
            brand: car.brandName,
            model: car.name,
            rentPrice: car.price,
            imageUrl: car.image,
            // Assuming CarEntity has availability
          ),
        );
      },
    );
  }

  void _navigateToDetails(BuildContext context, CarEntity car) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CarDetailsPage(car: car),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutSine;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }
}
