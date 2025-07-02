import 'package:flutter/material.dart';
import 'package:x_go/features/carBooking/presentation/widgets/car_image_caursol_widget.dart';

class CarImageCarouselComponent extends StatefulWidget {
  const CarImageCarouselComponent({super.key});

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

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return CarImageCarouselWidget();
  }
}
