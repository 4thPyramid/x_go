import 'package:json_annotation/json_annotation.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel extends CarEntity {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'attributes')
  final CarAttributesModel attributes;

  @JsonKey(name: 'relationship')
  final CarRelationshipModel relationship;

   CarModel({
    required this.id,
    required this.attributes,
    required this.relationship,
  }) : super(
    id: id,
    name: attributes.name,
    year: attributes.year,
    price: attributes.price,
    image: attributes.image,
    typeId: relationship.types.typeId,
    typeName: relationship.types.typeName,
    brandId: relationship.brand.brandId,
    brandName: relationship.brand.brandName,
  );

  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}

@JsonSerializable()
class CarAttributesModel {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'year')
  final String year;

  @JsonKey(name: 'price')
  final String price;

  @JsonKey(name: 'image')
  final String image;

  const CarAttributesModel({
    required this.name,
    required this.year,
    required this.price,
    required this.image,
  });

  factory CarAttributesModel.fromJson(Map<String, dynamic> json) =>
      _$CarAttributesModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarAttributesModelToJson(this);
}

@JsonSerializable()
class CarRelationshipModel {
  @JsonKey(name: 'Types')
  final CarTypeModel types;

  @JsonKey(name: 'Brand')
  final CarBrandModel brand;

  const CarRelationshipModel({
    required this.types,
    required this.brand,
  });

  factory CarRelationshipModel.fromJson(Map<String, dynamic> json) =>
      _$CarRelationshipModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarRelationshipModelToJson(this);
}

@JsonSerializable()
class CarTypeModel {
  @JsonKey(name: 'type_id')
  final String typeId;

  @JsonKey(name: 'type_name')
  final String typeName;

  const CarTypeModel({
    required this.typeId,
    required this.typeName,
  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) =>
      _$CarTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarTypeModelToJson(this);
}

@JsonSerializable()
class CarBrandModel {
  @JsonKey(name: 'brand_id')
  final int brandId;

  @JsonKey(name: 'brand_name')
  final String brandName;

  const CarBrandModel({
    required this.brandId,
    required this.brandName,
  });

  factory CarBrandModel.fromJson(Map<String, dynamic> json) =>
      _$CarBrandModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarBrandModelToJson(this);
}
