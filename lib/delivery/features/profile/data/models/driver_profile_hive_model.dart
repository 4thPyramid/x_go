import 'package:hive/hive.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';

part 'driver_profile_hive_model.g.dart';

@HiveType(typeId: 5) // غير الـ typeId لو مستخدم IDs تانية قبل كده
class DriverProfileHiveModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phone;

  DriverProfileHiveModel({required this.id, this.name, this.email, this.phone});

  factory DriverProfileHiveModel.fromEntity(DriverProfileEntity entity) {
    return DriverProfileHiveModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
    );
  }

  DriverProfileEntity toEntity() {
    return DriverProfileEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      locations: [], // تجاهلناها للكاش
      bookings: [], // تجاهلناها للكاش
    );
  }
}
