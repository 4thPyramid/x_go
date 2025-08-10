import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class CarModel {
  final String id;
  final CarAttributes attributes;
  final CarRelationships relationships;

  CarModel({
    required this.id,
    required this.attributes,
    required this.relationships,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id']?.toString() ?? '',
      attributes: CarAttributes.fromJson(json['attributes'] ?? {}),
      relationships: CarRelationships.fromJson(json['relationships'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.toJson(),
      'relationships': relationships.toJson(),
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
      typeName: relationships.types?.typeName ?? '',
      brandName: relationships.brand?.brandName ?? '',
      modelName: relationships.modelNames?.modelName ?? '',
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
  final String modelName;
  final String brand;

  CarAttributes({
    required this.year,
    required this.price,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
    required this.seatsCount,
    required this.acceleration,
    required this.image,
    required this.modelName,
    required this.brand,
  });

  factory CarAttributes.fromJson(Map<String, dynamic> json) {
    return CarAttributes(
      year: json['year']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      engineType: json['engine_type']?.toString() ?? '',
      transmissionType: json['transmission_type']?.toString() ?? '',
      seatType: json['seat_type']?.toString() ?? '',
      seatsCount: json['seats_count'] is int
          ? json['seats_count']
          : int.tryParse(json['seats_count']?.toString() ?? '0') ?? 0,
      acceleration: json['acceleration']?.toString() ?? '0.0',
      image: json['image']?.toString() ?? '',
      modelName: json['model_name']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
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
      'model_name': modelName,
      'brand': brand,
    };
  }
}

class CarRelationships {
  final List<CarDetail>? cars;
  final CarType? types;
  final CarBrand? brand;
  final CarModelName? modelNames;
  final CarRatings? ratings;

  CarRelationships({
    this.cars,
    this.types,
    this.brand,
    this.modelNames,
    this.ratings,
  });

  factory CarRelationships.fromJson(Map<String, dynamic> json) {
    return CarRelationships(
      cars: (json['cars'] as List<dynamic>?)
          ?.map((e) => CarDetail.fromJson(e))
          .toList(),
      types: json['types'] != null ? CarType.fromJson(json['types']) : null,
      brand: json['brand'] != null ? CarBrand.fromJson(json['brand']) : null,
      modelNames: json['model_names'] != null
          ? CarModelName.fromJson(json['model_names'])
          : null,
      ratings: json['ratings'] != null
          ? CarRatings.fromJson(json['ratings'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cars': cars?.map((e) => e.toJson()).toList(),
      'types': types?.toJson(),
      'brand': brand?.toJson(),
      'model_names': modelNames?.toJson(),
      'ratings': ratings?.toJson(),
    };
  }
}

class CarDetail {
  final int id;
  final String capacity;
  final String description;
  final String color;
  final String plateNumber;
  final String status;
  final String image;

  CarDetail({
    required this.id,
    required this.capacity,
    required this.description,
    required this.color,
    required this.plateNumber,
    required this.status,
    required this.image,
  });

  factory CarDetail.fromJson(Map<String, dynamic> json) {
    return CarDetail(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      capacity: json['capacity']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      plateNumber: json['plate_number']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'capacity': capacity,
      'description': description,
      'color': color,
      'plate_number': plateNumber,
      'status': status,
      'image': image,
    };
  }
}

class CarType {
  final String typeId;
  final String typeName;

  CarType({required this.typeId, required this.typeName});

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      typeId: json['type_id']?.toString() ?? '',
      typeName: json['type_name']?.toString() ?? '',
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
      brandId: json['brand_id'] is int
          ? json['brand_id']
          : int.tryParse(json['brand_id']?.toString() ?? '0') ?? 0,
      brandName: json['brand_name']?.toString() ?? '',
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
      modelNameId: json['model_name_id']?.toString() ?? '',
      modelName: json['model_name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'model_name_id': modelNameId, 'model_name': modelName};
  }
}

class CarRatings {
  final int ratingsCount;

  CarRatings({required this.ratingsCount});

  factory CarRatings.fromJson(Map<String, dynamic> json) {
    return CarRatings(
      ratingsCount: json['ratings_count'] is int
          ? json['ratings_count']
          : int.tryParse(json['ratings_count']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ratings_count': ratingsCount};
  }
}
