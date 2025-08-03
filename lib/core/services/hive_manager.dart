import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/delivery/features/home/data/model/order_status_hive_model.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_profile_hive_model.dart';

/// Hive initialization manager for the app
class HiveManager {
  static bool _isInitialized = false;

  /// Initialize Hive and open all required boxes
  static Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize Hive
      await Hive.initFlutter();
      print('🚀 Hive initialized');

      // Register adapters for delivery features (existing code)
      try {
        Hive.registerAdapter(OrderStatusHiveModelAdapter());
        print('✅ OrderStatusHiveModelAdapter registered');
      } catch (e) {
        print('⚠️ OrderStatusHiveModelAdapter already registered: $e');
      }

      try {
        Hive.registerAdapter(DriverProfileHiveModelAdapter());
        print('✅ DriverProfileHiveModelAdapter registered');
      } catch (e) {
        print('⚠️ DriverProfileHiveModelAdapter already registered: $e');
      }

      // Open all required boxes
      await Hive.openBox('favorites_box');
      print('📦 Opened favorites_box');

      await Hive.openBox('orders_box');
      print('📦 Opened orders_box');

      await Hive.openBox<DriverProfileHiveModel>('driverProfileBox');
      print('� Opened driverProfileBox');

      _isInitialized = true;
      print('🎉 All Hive boxes initialized successfully');
    } catch (e) {
      print('❌ Failed to initialize Hive: $e');
      rethrow;
    }
  }

  /// Check if Hive is initialized
  static bool get isInitialized => _isInitialized;

  /// Get favorites box
  static Box getFavoritesBox() {
    if (!_isInitialized) {
      throw StateError(
        'Hive not initialized. Call HiveManager.initialize() first.',
      );
    }
    return Hive.box('favorites_box');
  }

  /// Get orders box
  static Box getOrdersBox() {
    if (!_isInitialized) {
      throw StateError(
        'Hive not initialized. Call HiveManager.initialize() first.',
      );
    }
    return Hive.box('orders_box');
  }

  /// Get driver profile box
  static Box<DriverProfileHiveModel> getDriverProfileBox() {
    if (!_isInitialized) {
      throw StateError(
        'Hive not initialized. Call HiveManager.initialize() first.',
      );
    }
    return Hive.box<DriverProfileHiveModel>('driverProfileBox');
  }

  /// Close all boxes and dispose Hive
  static Future<void> dispose() async {
    try {
      await Hive.close();
      _isInitialized = false;
      print('🗄️ Hive disposed successfully');
    } catch (e) {
      print('❌ Error disposing Hive: $e');
    }
  }

  /// Clear all data (for debugging/reset)
  static Future<void> clearAllData() async {
    try {
      if (_isInitialized) {
        final favBox = Hive.box('favorites_box');
        await favBox.clear();
        await favBox.flush();
        print('🧹 All Hive data cleared');
      }
    } catch (e) {
      print('❌ Error clearing Hive data: $e');
    }
  }

  /// Debug: Print all box contents
  static void debugPrintBoxContents() {
    if (!_isInitialized) {
      print('❌ Hive not initialized');
      return;
    }

    try {
      final favBox = Hive.box('favorites_box');
      print('📦 Favorites Box Contents:');
      print('  - Keys: ${favBox.keys.toList()}');
      print('  - Length: ${favBox.length}');

      for (final key in favBox.keys) {
        final value = favBox.get(key);
        print('  - $key: ${value?.toString().substring(0, 100) ?? 'null'}...');
      }
    } catch (e) {
      print('❌ Error printing box contents: $e');
    }
  }
}
