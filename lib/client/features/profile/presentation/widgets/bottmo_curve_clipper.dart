// import 'package:flutter/material.dart';

// class BottomCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     path.lineTo(0, size.height - 100); // من اليسار لقبل النهاية بشوية

//     path.quadraticBezierTo(
//       size.width / 2, size.height, // نقطة التحكم والذروة (نص العرض)
//       size.width, size.height - 100, // نهاية الكيرف
//     );

//     path.lineTo(size.width, 0); // يمين فوق


//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
