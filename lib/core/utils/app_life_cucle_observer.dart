// App lifecycle observer to handle app state changes
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_profile_hive_model.dart';

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
        final profileBox = Hive.box<DriverProfileHiveModel>('driverProfileBox');
        // Flush the cache to disk
        box.flush();
        profileBox.flush();
        print('💾 Successfully flushed Hive cache to disk');
      } else {
        print('⚠️ Hive box is not open, cannot flush');
      }
    } catch (e) {
      print('❌ Error flushing Hive cache: $e');
    }
  }
}
