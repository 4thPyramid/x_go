import 'package:flutter/material.dart';

class BrandSelector extends StatelessWidget {
  const BrandSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Brand car', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: List.generate(3, (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: index == 1 ? Colors.black : Colors.grey[200],
                      ),
                      child: Center(
                        child: Icon(Icons.directions_car,
                            color: index == 1 ? Colors.white : Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text("Ferrari", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}

