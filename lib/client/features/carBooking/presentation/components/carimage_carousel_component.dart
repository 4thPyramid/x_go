import 'package:flutter/material.dart';
import 'package:x_go/client/features/carBooking/presentation/widgets/car_image_caursol_widget.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class CarImageCarouselComponent extends StatefulWidget {
  final CarEntity? car;
  const CarImageCarouselComponent({super.key, this.car});

  @override
  State<CarImageCarouselComponent> createState() =>
      _CarImageCarouselComponentState();
}

class _CarImageCarouselComponentState extends State<CarImageCarouselComponent> {
  final List<String> imageList = [
    'assets/images/Group 7.png',
    'assets/images/Group 7.png',
    'assets/images/Group 7.png',
  ];

  final PageController _pageController = PageController();

  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return CarImageCarouselWidget(car: widget.car);
  }
}
