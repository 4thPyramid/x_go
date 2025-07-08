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
}

class CarAttributes {
  final String name;
  final String year;
  final String price;
  final String engineType;
  final String transmissionType;
  final String seatType;
  final int seatsCount;
  final String acceleration;
  final String image;

  CarAttributes({
    required this.name,
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
      name: json['name'] as String,
      year: json['year'] as String,
      price: json['price'] as String,
      engineType: json['engine_type'] as String,
      transmissionType: json['transmission_type'] as String,
      seatType: json['seat_type'] as String,
      seatsCount: json['seats_count'] as int,
      acceleration: json['acceleration'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
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

  CarRelationships({
    required this.types,
    required this.brand,
  });

  factory CarRelationships.fromJson(Map<String, dynamic> json) {
    return CarRelationships(
      types: CarType.fromJson(json['Types']),
      brand: CarBrand.fromJson(json['Brand']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Types': types.toJson(),
      'Brand': brand.toJson(),
    };
  }
}

class CarType {
  final String typeId;
  final String typeName;

  CarType({
    required this.typeId,
    required this.typeName,
  });

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      typeId: json['type_id'] as String,
      typeName: json['type_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'type_name': typeName,
    };
  }
}

class CarBrand {
  final int brandId;
  final String brandName;

  CarBrand({
    required this.brandId,
    required this.brandName,
  });

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      brandId: json['brand_id'] as int,
      brandName: json['brand_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand_id': brandId,
      'brand_name': brandName,
    };
  }
}
