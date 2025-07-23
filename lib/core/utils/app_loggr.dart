import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // عدد دوال الـ Stack
      errorMethodCount: 8, // عدد دوال الخطأ
      lineLength: 100, // عدد الحروف في كل سطر
      colors: true,
      printEmojis: true, // عرض الإيموجي
      printTime: true, // عرض الوقت
    ),
  );

  static void i(dynamic message) {
    _logger.i(message);
  }

  static void d(dynamic message) {
    _logger.d(message);
  }

  static void w(dynamic message) {
    _logger.w(message);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void t(dynamic message) {
    _logger.t(message);
  }

  static void f(dynamic message) {
    _logger.f(message);
  }
}
