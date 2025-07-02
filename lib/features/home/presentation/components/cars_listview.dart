import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit.dart';
import '../widgets/car_card_widget.dart';

class CarsListview extends StatelessWidget {
  const CarsListview({super.key});

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<HomeCubit, HomeState>(
      
      builder: (context, state) {
        
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is HomeLoaded) {
          final cars = state.cars;

          if (cars.isEmpty) {
            return const Center(child: Text("No cars found with this filter."));
          }

          return ListView.separated(
            itemCount: cars.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 7.h),
            itemBuilder: (context, index) {
              final car = cars[index];
              return InkWell(
                onTap: () {
                  // context.push('/carDetails'); // يمكنك تعديلها لاحقًا لتأخذ ID
                },
                child: CarCardWidget(
                  brand: car.relationship.brand.brandName ?? "Unknown",
                  model: car.attributes.name ?? "Unknown",
                  rentPrice: '\$${car.attributes.price ?? '0'}',
                  imageUrl: car.attributes.image ?? 'assets/images/car.png', // تأكد من المسار الصحيح
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink(); // HomeInitial أو أي حالة غير متوقعة
        }
      },
    );
  }
}
