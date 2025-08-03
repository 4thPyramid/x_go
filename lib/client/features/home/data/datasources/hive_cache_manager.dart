/*import 'package:hive_flutter/hive_flutter.dart';

/// Hive initialization and setup for caching
class HiveCacheManager {
  static bool _isInitialized = false;
  
  /// Initialize Hive and register adapters
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Initialize Hive
      await Hive.initFlutter();
      
      // TODO: Register adapters after running build_runner
      // Hive.registerAdapter(CachedCarsDataAdapter());
      // Hive.registerAdapter(CachedFilterInfoAdapter());
      // Hive.registerAdapter(CacheMetadataAdapter());
      
      _isInitialized = true;
      print('🚀 Hive cache manager initialized successfully');
    } catch (e) {
      print('❌ Failed to initialize Hive cache manager: $e');
      rethrow;
    }
  }
  
  /// Check if Hive is initialized
  static bool get isInitialized => _isInitialized;
  
  /// Close all Hive boxes (call on app disposal)
  static Future<void> dispose() async {
    try {
      await Hive.close();
      _isInitialized = false;
      print('🗄️ Hive cache manager disposed');
    } catch (e) {
      print('❌ Error disposing Hive cache manager: $e');
    }
  }
  
  /// Clear all Hive data (for debugging/reset)
  static Future<void> clearAllData() async {
    try {
      await Hive.deleteFromDisk();
      _isInitialized = false;
      print('🧹 All Hive data cleared from disk');
    } catch (e) {
      print('❌ Error clearing Hive data: $e');
    }
  }
}
*/
