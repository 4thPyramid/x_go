// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateResponse _$DriverUpdateResponseFromJson(
  Map<String, dynamic> json,
) => DriverUpdateResponse(
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : DriverUpdateDataResponse.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DriverUpdateResponseToJson(
  DriverUpdateResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

DriverUpdateDataResponse _$DriverUpdateDataResponseFromJson(
  Map<String, dynamic> json,
) => DriverUpdateDataResponse(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$DriverUpdateDataResponseToJson(
  DriverUpdateDataResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
