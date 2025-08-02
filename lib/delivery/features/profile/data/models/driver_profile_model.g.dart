// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverProfileResponse _$DriverProfileResponseFromJson(
        Map<String, dynamic> json) =>
    DriverProfileResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DriverProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DriverProfileResponseToJson(
        DriverProfileResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

DriverProfileData _$DriverProfileDataFromJson(Map<String, dynamic> json) =>
    DriverProfileData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DriverProfileDataToJson(DriverProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'locations': instance.locations,
      'bookings': instance.bookings,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      id: (json['id'] as num?)?.toInt(),
      location: json['location'] as String?,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
    };

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
    };
