import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/client/features/home/data/models/location_active_hive_model.dart';
import 'package:x_go/core/services/hive_manager.dart';

abstract class ActiveLocationLocalDataSource {
  Future<void> cacheActiveLocation(LocationActiveHiveModel model);
  Future<LocationActiveHiveModel?> getCachedActiveLocation();
}

class ActiveLocationLocalDataSourceImpl
    implements ActiveLocationLocalDataSource {
  static const String _activeLocationKey = 'active_location';

  /// Get the active location box from HiveManager
  Box get _box => HiveManager.getActiveLocationBox();

  @override
  Future<void> cacheActiveLocation(LocationActiveHiveModel model) async {
    try {
      await _box.put(_activeLocationKey, model);
      await _box.flush();
    } catch (e) {
      print('Error caching active location: $e');
      rethrow;
    }
  }

  @override
  Future<LocationActiveHiveModel?> getCachedActiveLocation() async {
    try {
      final data = _box.get(_activeLocationKey);
      if (data != null && data is LocationActiveHiveModel) {
        return data;
      }
      return null;
    } catch (e) {
      print('Error getting cached active location: $e');
      return null;
    }
  }
}
