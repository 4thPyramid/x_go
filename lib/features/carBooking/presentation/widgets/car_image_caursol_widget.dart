import 'package:flutter/material.dart';

class CarImageCarouselWidget extends StatelessWidget {
  final List<String> images;
  final PageController controller;
  final int currentIndex;
  final void Function(int)? onPageChanged;

  const CarImageCarouselWidget({
    required this.images,
    required this.controller,
    required this.currentIndex,
    this.onPageChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (_, index) =>
                Image.asset(images[index], fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.black : Colors.white,
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
