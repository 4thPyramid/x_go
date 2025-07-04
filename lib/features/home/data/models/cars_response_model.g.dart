// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarsResponseModel _$CarsResponseModelFromJson(Map<String, dynamic> json) =>
    CarsResponseModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarsResponseModelToJson(CarsResponseModel instance) =>
    <String, dynamic>{'data': instance.data};
