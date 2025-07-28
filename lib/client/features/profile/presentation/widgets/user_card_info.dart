import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/utils/image_url_helper.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String lastName;
  final String email;
    final VoidCallback? onPressed;


  const UserInfoCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.lastName,
    this.onPressed,
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
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                ImageUrlHelper.normalizeImageUrl(imageUrl),
              ),
              onBackgroundImageError: (exception, stackTrace) {
                ImageUrlHelper.logImageError(imageUrl, exception);
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        lastName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(email, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: Icon(Icons.edit, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
