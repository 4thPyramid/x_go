import 'package:json_annotation/json_annotation.dart';
import 'package:x_go/features/home/domain/entity/filter_info_entity.dart' show BrandEntity, FilterInfoEntity, TypeEntity;

part 'filter_info_model.g.dart';

@JsonSerializable()
class FilterInfoModel extends FilterInfoEntity {
  @JsonKey(name: 'brands')
  final List<BrandModel> brands;

  @JsonKey(name: 'types')
  final List<TypeModel> types;

  @JsonKey(name: 'max_price')
  final String maxPrice;

  @JsonKey(name: 'min_price')
  final String minPrice;

  const FilterInfoModel({
    required this.brands,
    required this.types,
    required this.maxPrice,
    required this.minPrice,
  }) : super(
    brands: brands,
    types: types,
    maxPrice: maxPrice,
    minPrice: minPrice,
  );

  factory FilterInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FilterInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterInfoModelToJson(this);
}

@JsonSerializable()
class BrandModel extends BrandEntity {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'logo')
  final String logo;

  const BrandModel({
    required this.name,
    required this.logo,
  }) : super(name: name, logo: logo);

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);
  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}

@JsonSerializable()
class TypeModel extends TypeEntity {
  @JsonKey(name: 'name')
  final String name;

  const TypeModel({
    required this.name,
  }) : super(name: name);

  factory TypeModel.fromJson(Map<String, dynamic> json) =>
      _$TypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TypeModelToJson(this);
}
