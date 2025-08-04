import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_hive_model.dart';
import 'package:x_go/core/services/hive_manager.dart';

abstract class CarDetailLocalDataSource {
  Future<void> cacheCarDetail(String id, CarDetailHiveModel carDetail);
  Future<CarDetailHiveModel?> getCachedCarDetail(String id);
}

class CarDetailLocalDataSourceImpl implements CarDetailLocalDataSource {
  /// Get the car detail box from HiveManager
  Box<CarDetailHiveModel> get _box => HiveManager.getCarDetailBox();

  @override
  Future<void> cacheCarDetail(String id, CarDetailHiveModel carDetail) async {
    try {
      await _box.put(id, carDetail);
      await _box.flush();
    } catch (e) {
      print('Error caching car detail: $e');
      rethrow;
    }
  }

  @override
  Future<CarDetailHiveModel?> getCachedCarDetail(String id) async {
    try {
      final data = _box.get(id);
      if (data != null) {
        return data;
      }
      return null;
    } catch (e) {
      print('Error getting cached car detail: $e');
      return null;
    }
  }
}
