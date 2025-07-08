import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const LocationButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 235, 233), // خلفية ناعمة
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFEB9C30), // لون برتقالي
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  color: Color(0xFF5B5B5B), // رمادي أنيق
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
