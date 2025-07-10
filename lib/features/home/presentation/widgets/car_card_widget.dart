import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarCardWidget extends StatelessWidget {
  final String brand;
  final String model;
  final String rentPrice;
  final String imageUrl;

  const CarCardWidget({
    super.key,
    required this.brand,
    required this.model,
    required this.rentPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          _buildImage(),
          Container(
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              brand,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Text(
              model,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 36,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "price",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  '$rentPrice',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 19,
              child: const Icon(Icons.arrow_forward, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: 240,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: double.infinity,
          height: 240,
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          width: double.infinity,
          height: 240,
          color: Colors.grey[300],
          child: const Icon(Icons.car_rental, size: 50, color: Colors.grey),
        ),
      );
    } else {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        height: 240,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: double.infinity,
          height: 240,
          color: Colors.grey[300],
          child: const Icon(Icons.car_rental, size: 50, color: Colors.grey),
        ),
      );
    }
  }
}
