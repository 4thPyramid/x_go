import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const ProfileSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,  
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            ...items
          ],
        ),
      ),
    );
  }
}
