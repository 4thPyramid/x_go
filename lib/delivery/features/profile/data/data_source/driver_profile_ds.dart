import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_profile_model.dart';

import '../../../../../core/utils/app_loggr.dart';

abstract class DriverProfileDataSource {
  Future<DriverProfileResponse> getDriverProfile();
}

class DriverProfileDataSourceImpl implements DriverProfileDataSource {
  final ApiConsumer apiConsumer;

  DriverProfileDataSourceImpl({required this.apiConsumer});

  @override
  Future<DriverProfileResponse> getDriverProfile() async {
    final driverId = CacheHelper.getDriverId();

    if (driverId == null) {
      AppLogger.e("Driver ID not found in cache");
      throw Exception("Driver ID not found in cache");
    }

    final driverProfile = await apiConsumer.get(
      EndpointsStrings.driverProfile.replaceFirst(':id', driverId),
    );
    return DriverProfileResponse.fromJson(driverProfile);
  }
}
