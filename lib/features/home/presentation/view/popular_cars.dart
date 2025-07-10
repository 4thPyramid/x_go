import 'package:flutter/material.dart';
import 'package:x_go/features/home/presentation/components/car_component.dart';

class PopularCarsView extends StatelessWidget {
  const PopularCarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: CarsListComponent()));
  }
}
