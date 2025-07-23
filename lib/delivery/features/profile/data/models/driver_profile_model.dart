import 'package:json_annotation/json_annotation.dart';
import 'package:x_go/delivery/features/profile/data/repo/driver_profile_entity.dart';

part 'driver_profile_model.g.dart';

@JsonSerializable()
class DriverProfileResponse {
  final String? message;
  final DriverProfileData? data;

  DriverProfileResponse({this.message, this.data});

  factory DriverProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverProfileResponseToJson(this);
}

@JsonSerializable()
class DriverProfileData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final List<LocationModel>? locations;
  final List<BookingModel>? bookings;

  DriverProfileData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.locations,
    this.bookings,
  });

  factory DriverProfileData.fromJson(Map<String, dynamic> json) =>
      _$DriverProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$DriverProfileDataToJson(this);

  DriverProfileEntity toEntity() => DriverProfileEntity(
    id: id ?? 0,
    name: name ?? '',
    email: email ?? '',
    phone: phone ?? '',
    locations: locations?.map((e) => e.toEntity()).toList() ?? [],
    bookings: bookings?.map((e) => e.toEntity()).toList() ?? [],
  );
}

@JsonSerializable()
class LocationModel {
  final int? id;
  final String? location;

  LocationModel({this.id, this.location});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  LocationEntity toEntity() =>
      LocationEntity(id: id ?? 0, location: location ?? '');
}

@JsonSerializable()
class BookingModel {
  final int? id;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  BookingModel({this.id, this.createdAt});

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  BookingEntity toEntity() =>
      BookingEntity(id: id ?? 0, createdAt: createdAt ?? '');
}
