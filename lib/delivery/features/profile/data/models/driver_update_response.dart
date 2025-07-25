import 'package:json_annotation/json_annotation.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_update_entity.dart';

part 'driver_update_response.g.dart';

@JsonSerializable()
class DriverUpdateResponse {
  final String message;
  DriverUpdateDataResponse? data;

  DriverUpdateResponse({required this.message, this.data});

  factory DriverUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverUpdateResponseFromJson(json);
}

@JsonSerializable()
class DriverUpdateDataResponse {
  final int id;
  final String name;
  final String email;
  final String phone;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  DriverUpdateDataResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });
  DriverUpdateEntity toEntity() =>
      DriverUpdateEntity(id: id, name: name, email: email, phone: phone);

  factory DriverUpdateDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverUpdateDataResponseFromJson(json);
}
