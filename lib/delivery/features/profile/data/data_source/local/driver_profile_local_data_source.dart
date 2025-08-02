import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_profile_hive_model.dart';

abstract class DriverProfileLocalDataSource {
  Future<void> cacheDriverProfile(DriverProfileHiveModel profile);
  Future<DriverProfileHiveModel?> getCachedDriverProfile();
}

class DriverProfileLocalDataSourceImpl implements DriverProfileLocalDataSource {
  final Box<DriverProfileHiveModel> hiveBox;

  DriverProfileLocalDataSourceImpl(this.hiveBox);

  static const _key = 'cached_driver_profile';

  @override
  Future<void> cacheDriverProfile(DriverProfileHiveModel profile) async {
    await hiveBox.put(_key, profile);
  }

  @override
  Future<DriverProfileHiveModel?> getCachedDriverProfile() async {
    return hiveBox.get(_key);
  }
}
