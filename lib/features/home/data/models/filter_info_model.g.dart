// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterInfoModel _$FilterInfoModelFromJson(Map<String, dynamic> json) =>
    FilterInfoModel(
      brands: (json['brands'] as List<dynamic>)
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((e) => TypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxPrice: json['max_price'] as String,
      minPrice: json['min_price'] as String,
    );

Map<String, dynamic> _$FilterInfoModelToJson(FilterInfoModel instance) =>
    <String, dynamic>{
      'brands': instance.brands,
      'types': instance.types,
      'max_price': instance.maxPrice,
      'min_price': instance.minPrice,
    };

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) =>
    BrandModel(name: json['name'] as String, logo: json['logo'] as String);

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{'name': instance.name, 'logo': instance.logo};

TypeModel _$TypeModelFromJson(Map<String, dynamic> json) =>
    TypeModel(name: json['name'] as String);

Map<String, dynamic> _$TypeModelToJson(TypeModel instance) => <String, dynamic>{
  'name': instance.name,
};
