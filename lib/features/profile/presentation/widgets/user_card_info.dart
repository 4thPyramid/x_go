import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(location, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.edit, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
