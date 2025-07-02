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
      id: json['id'],
      attributes: CarAttributes.fromJson(json['attributes']),
      relationship: CarRelationships.fromJson(json['relationship']),
    );
  }
}

class CarAttributes {
  final String name;
  final String year;
  final String price;
  final String image;

  CarAttributes({
    required this.name,
    required this.year,
    required this.price,
    required this.image,
  });

  factory CarAttributes.fromJson(Map<String, dynamic> json) {
    return CarAttributes(
      name: json['name'],
      year: json['year'],
      price: json['price'],
      image: json['image'],
    );
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
      typeId: json['type_id'],
      typeName: json['type_name'],
    );
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
      brandId: json['brand_id'],
      brandName: json['brand_name'],
    );
  }
}
