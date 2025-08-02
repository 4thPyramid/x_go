// App lifecycle observer to handle app state changes
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    print('🔄 App lifecycle state changed to: $state');

    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        print('🔄 App is closing, flushing Hive cache...');
        _flushHiveCache();
        break;
      case AppLifecycleState.resumed:
        print('✅ App resumed');
        break;
      case AppLifecycleState.hidden:
        print('🔄 App hidden, flushing Hive cache...');
        _flushHiveCache();
        break;
    }
  }

  void _flushHiveCache() {
    try {
      if (Hive.isBoxOpen('orders_box')) {
        final box = Hive.box('orders_box');
        box.flush();
        print('💾 Successfully flushed Hive cache to disk');
      } else {
        print('⚠️ Hive box is not open, cannot flush');
      }
    } catch (e) {
      print('❌ Error flushing Hive cache: $e');
    }
  }
}
