// core/utils/debouncer.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  Timer? _timer;

  void debounce({
    required Duration duration,
    required VoidCallback onDebounce,
  }) {
    cancel();
    _timer = Timer(duration, onDebounce);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    cancel();
  }

  bool get isActive => _timer?.isActive ?? false;
}
