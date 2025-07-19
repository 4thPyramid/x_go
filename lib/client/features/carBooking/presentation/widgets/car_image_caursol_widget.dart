import 'package:flutter/material.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class CarImageCarouselWidget extends StatefulWidget {
  final CarEntity? car;
  const CarImageCarouselWidget({super.key, this.car});

  @override
  State<CarImageCarouselWidget> createState() => _CarImageCarouselState();
}

class _CarImageCarouselState extends State<CarImageCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> imageList = [
    'assets/images/Group 7.png',
    'assets/images/Group 7.png',
    'assets/images/Group 7.png',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: imageList.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (_, index) =>
                Image.network(widget.car!.image, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageList.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
