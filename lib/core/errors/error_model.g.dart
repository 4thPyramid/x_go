// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => ErrorModel(
  message: json['message'] as String,
  key: json['key'] as String?,
  data: json['data'] as List<dynamic>?,
);

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'msg': instance.message,
      //   'key': instance.key,
      // 'data': instance.data,
    };
