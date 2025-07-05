import 'package:flutter/material.dart';

Widget darkOverlay() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.27),

          Colors.black.withOpacity(0.28),
        ],
      ),
    ),
  );
}
