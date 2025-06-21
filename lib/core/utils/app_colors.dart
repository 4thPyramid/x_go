// // lib/core/constants/app_colors.dart
// import 'package:flutter/material.dart';

// class AppColors {
 
//   static const Color primary = Color(0xFF3B82F6); // أزرق رئيسي
//   static const Color textOnPrimary = Colors.white;
//   static const LinearGradient primaryGradient = LinearGradient(
//     colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   // ✅ الألوان الجديدة المطلوبة
//   static const Color background = Color(0xFFF4F6FA);
//   static const Color surface = Colors.white;

//   static const Color textPrimary = Color(0xFF1F2937); // رمادي غامق
//   static const Color textSecondary = Color(0xFF6B7280); // رمادي متوسط
//   static const Color textMuted = Color(0xFF9CA3AF); // رمادي فاتح

//   static const Color divider = Color(0xFFE5E7EB); // لون حدود خفيف
//   static const Color shadow = Color(0x1A000000); // ظل خفيف (10% أسود)

//   static const Color success = Color(0xFF10B981); // أخضر
//   static const Color warning = Color(0xFFF59E0B); // برتقالي
//   static const Color info = Color(0xFF3B82F6);    // أزرق (نفس لون primary)


//   // الألوان الأساسية - Primary Colors
//   static const Color primary = Color(0xFF2E3A4B);           // أزرق داكن مهني
//   static const Color primaryLight = Color(0xFF4A5B6C);      // أزرق فاتح
//   static const Color primaryDark = Color(0xFF1B2531);       // أزرق أغمق
  
//   // الألوان الثانوية - Secondary Colors
//   static const Color secondary = Color(0xFFB7860F);         // ذهبي للقانون
//   static const Color secondaryLight = Color(0xFFD4A429);    // ذهبي فاتح
//   static const Color secondaryDark = Color(0xFF8B6508);     // ذهبي داكن
  
//   // الألوان المحايدة - Neutral Colors
//   static const Color background = Color(0xFFFAFAFA);        // خلفية رئيسية
//   static const Color surface = Color(0xFFFFFFFF);           // أسطح البطاقات
//   static const Color surfaceLight = Color(0xFFF5F7FA);      // أسطح فاتحة
  
//   // ألوان النصوص - Text Colors
//   static const Color textPrimary = Color(0xFF1C1E21);       // نص أساسي
//   static const Color textSecondary = Color(0xFF606770);     // نص ثانوي
//   static const Color textMuted = Color(0xFF8A8D91);         // نص باهت
//   static const Color textOnPrimary = Color(0xFFFFFFFF);     // نص على الألوان الأساسية
  
//   // ألوان الحالة - Status Colors
//   static const Color success = Color(0xFF4CAF50);           // نجاح
//   static const Color warning = Color(0xFFFF9800);           // تحذير
//   static const Color error = Color(0xFFF44336);             // خطأ
//   static const Color info = Color(0xFF2196F3);              // معلومات
  
//   // ألوان خاصة بالتطبيق - App Specific Colors
//   static const Color accent = Color(0xFF6366F1);            // لون مميز
//   static const Color border = Color(0xFFE1E5E9);            // حدود
//   static const Color divider = Color(0xFFEEEFF2);           // فواصل
//   static const Color shadow = Color(0x1A000000);            // ظلال
  
//   // تدرجات لونية - Gradients
//   static const LinearGradient primaryGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [primary, primaryLight],
//   );
  
//   static const LinearGradient secondaryGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [secondary, secondaryLight],
//   );
  
//   static const LinearGradient accentGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [accent, Color(0xFF818CF8)],
//   );
  
//   // ألوان خاصة بالشاشات المختلفة
//   static const Color dashboardCard1 = Color(0xFF6366F1);    // بطاقة الإحصائيات 1
//   static const Color dashboardCard2 = Color(0xFF8B5CF6);    // بطاقة الإحصائيات 2
//   static const Color dashboardCard3 = Color(0xFF06B6D4);    // بطاقة الإحصائيات 3
//   static const Color dashboardCard4 = Color(0xFF10B981);    // بطاقة الإحصائيات 4
  
//   // ألوان خاصة بالأيقونات
//   static const Color iconPrimary = primary;
//   static const Color iconSecondary = textSecondary;
//   static const Color iconAccent = accent;
  
//   // ألوان خاصة بشريط التنقل السفلي
//   static const Color bottomNavSelected = primary;
//   static const Color bottomNavUnselected = textMuted;
//   static const Color bottomNavBackground = surface;
  
// }