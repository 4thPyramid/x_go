import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class CarModel {
  final String id;
  final CarAttributes attributes;
  final CarRelationships relationship;

  CarModel({
    required this.id,
    required this.attributes,
    required this.relationship,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] as String,
      attributes: CarAttributes.fromJson(json['attributes']),
      relationship: CarRelationships.fromJson(json['relationship']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.toJson(),
      'relationship': relationship.toJson(),
    };
  }

  CarEntity toEntity() {
    return CarEntity(
      id: id,
      year: attributes.year,
      price: attributes.price,
      engineType: attributes.engineType,
      transmissionType: attributes.transmissionType,
      seatType: attributes.seatType,
      seatsCount: attributes.seatsCount,
      acceleration: attributes.acceleration,
      image: attributes.image,
      typeName: relationship.types.typeName,
      brandName: relationship.brand.brandName,
      modelName: relationship.modelNames.modelName,
    );
  }
}

class CarAttributes {
  final String year;
  final String price;
  final String engineType;
  final String transmissionType;
  final String seatType;
  final int seatsCount;
  final String acceleration;
  final String image;

  CarAttributes({
    required this.year,
    required this.price,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
    required this.seatsCount,
    required this.acceleration,
    required this.image,
  });

  factory CarAttributes.fromJson(Map<String, dynamic> json) {
    return CarAttributes(
      year: json['year'] as String? ?? '',
      price: json['price'] as String? ?? '0',
      engineType: json['engine_type'] as String? ?? '',
      transmissionType: json['transmission_type'] as String? ?? '',
      seatType: json['seat_type'] as String? ?? '',
      seatsCount: json['seats_count'] as int? ?? 0,
      acceleration: json['acceleration'] as String? ?? '0.0',
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'price': price,
      'engine_type': engineType,
      'transmission_type': transmissionType,
      'seat_type': seatType,
      'seats_count': seatsCount,
      'acceleration': acceleration,
      'image': image,
    };
  }
}

class CarRelationships {
  final CarType types;
  final CarBrand brand;
  final CarModelName modelNames;

  CarRelationships({
    required this.types,
    required this.brand,
    required this.modelNames,
  });

  factory CarRelationships.fromJson(Map<String, dynamic> json) {
    return CarRelationships(
      types: CarType.fromJson(json['Types']),
      brand: CarBrand.fromJson(json['Brand']),
      modelNames: CarModelName.fromJson(json['Model Names']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Types': types.toJson(),
      'Brand': brand.toJson(),
      'Model Names': modelNames.toJson(),
    };
  }
}

class CarType {
  final String typeId;
  final String typeName;

  CarType({required this.typeId, required this.typeName});

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      typeId: json['type_id'] as String,
      typeName: json['type_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type_id': typeId, 'type_name': typeName};
  }
}

class CarBrand {
  final int brandId;
  final String brandName;

  CarBrand({required this.brandId, required this.brandName});

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      brandId: json['brand_id'] as int,
      brandName: json['brand_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'brand_id': brandId, 'brand_name': brandName};
  }
}

class CarModelName {
  final String modelNameId;
  final String modelName;

  CarModelName({required this.modelNameId, required this.modelName});

  factory CarModelName.fromJson(Map<String, dynamic> json) {
    return CarModelName(
      modelNameId: json['model_name_id'] as String,
      modelName: json['model_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'model_name_id': modelNameId, 'model_name': modelName};
  }
}
