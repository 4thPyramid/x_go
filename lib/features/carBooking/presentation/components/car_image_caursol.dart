import 'package:flutter/material.dart';

class CarImageCarousel extends StatefulWidget {
  const CarImageCarousel({super.key});

 

  @override
  State<CarImageCarousel> createState() => _CarImageCarouselState();
}

class _CarImageCarouselState extends State<CarImageCarousel> {
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
            itemBuilder: (_, index) => Image.asset(imageList[index], fit: BoxFit.cover),
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
