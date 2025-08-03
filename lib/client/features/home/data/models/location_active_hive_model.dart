import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/client/features/home/domain/entity/active_location.dart';

part 'location_active_hive_model.g.dart';

@HiveType(typeId: 4) // Ensure this typeId is unique across your Hive models
/// Model for active location data stored in Hive
class LocationActiveHiveModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String location;

  @HiveField(2)
  final String latitude;

  @HiveField(3)
  final String longitude;

  @HiveField(4)
  final bool isActive;

  LocationActiveHiveModel({
    required this.id,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.isActive,
  });

  /// Converts a LocationActive entity to a LocationActiveHiveModel
  factory LocationActiveHiveModel.fromEntity(LocationActive entity) {
    return LocationActiveHiveModel(
      id: entity.id,
      location: entity.location,
      latitude: entity.latitude,
      longitude: entity.longitude,
      isActive: entity.isActive,
    );
  }

  /// Converts this Hive model back to a LocationActive entity
  LocationActive toEntity() {
    return LocationActive(
      id: id,
      location: location,
      latitude: latitude,
      longitude: longitude,
      isActive: isActive,
    );
  }
}
