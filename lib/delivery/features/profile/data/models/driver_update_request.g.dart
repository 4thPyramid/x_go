// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateRequest _$DriverUpdateRequestFromJson(Map<String, dynamic> json) =>
    DriverUpdateRequest(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$DriverUpdateRequestToJson(
        DriverUpdateRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };
