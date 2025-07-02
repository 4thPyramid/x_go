// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
  id: json['id'] as String,
  attributes: CarAttributesModel.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
  relationship: CarRelationshipModel.fromJson(
    json['relationship'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
  'id': instance.id,
  'attributes': instance.attributes,
  'relationship': instance.relationship,
};

CarAttributesModel _$CarAttributesModelFromJson(Map<String, dynamic> json) =>
    CarAttributesModel(
      name: json['name'] as String,
      year: json['year'] as String,
      price: json['price'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$CarAttributesModelToJson(CarAttributesModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'year': instance.year,
      'price': instance.price,
      'image': instance.image,
    };

CarRelationshipModel _$CarRelationshipModelFromJson(
  Map<String, dynamic> json,
) => CarRelationshipModel(
  types: CarTypeModel.fromJson(json['Types'] as Map<String, dynamic>),
  brand: CarBrandModel.fromJson(json['Brand'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CarRelationshipModelToJson(
  CarRelationshipModel instance,
) => <String, dynamic>{'Types': instance.types, 'Brand': instance.brand};

CarTypeModel _$CarTypeModelFromJson(Map<String, dynamic> json) => CarTypeModel(
  typeId: json['type_id'] as String,
  typeName: json['type_name'] as String,
);

Map<String, dynamic> _$CarTypeModelToJson(CarTypeModel instance) =>
    <String, dynamic>{
      'type_id': instance.typeId,
      'type_name': instance.typeName,
    };

CarBrandModel _$CarBrandModelFromJson(Map<String, dynamic> json) =>
    CarBrandModel(
      brandId: (json['brand_id'] as num).toInt(),
      brandName: json['brand_name'] as String,
    );

Map<String, dynamic> _$CarBrandModelToJson(CarBrandModel instance) =>
    <String, dynamic>{
      'brand_id': instance.brandId,
      'brand_name': instance.brandName,
    };
