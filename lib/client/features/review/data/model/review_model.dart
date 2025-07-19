class ReviewModel {
  final String id;
  final CarAttributes attributes;
  final CarRelationship relationship;

  ReviewModel({
    required this.id,
    required this.attributes,
    required this.relationship,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      attributes: CarAttributes.fromJson(json['attributes'] ?? {}),
      relationship: CarRelationship.fromJson(json['relationship'] ?? {}),
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
      year: json['year'] ?? '',
      price: json['price'] ?? '',
      engineType: json['engine_type'] ?? '',
      transmissionType: json['transmission_type'] ?? '',
      seatType: json['seat_type'] ?? '',
      seatsCount: json['seats_count'] != null
          ? int.parse(json['seats_count'].toString())
          : 0,
      acceleration: json['acceleration'] ?? '',
      image: json['image'] ?? '',
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

class CarRelationship {
  final CarModelName modelName;
  final CarType type;
  final CarBrand brand;

  CarRelationship({
    required this.modelName,
    required this.type,
    required this.brand,
  });

  factory CarRelationship.fromJson(Map<String, dynamic> json) {
    return CarRelationship(
      modelName: CarModelName.fromJson(json['Model Names'] ?? {}),
      type: CarType.fromJson(json['Types'] ?? {}),
      brand: CarBrand.fromJson(json['Brand'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Model Names': modelName.toJson(),
      'Types': type.toJson(),
      'Brand': brand.toJson(),
    };
  }
}

class CarModelName {
  final String modelNameId;
  final String modelName;

  CarModelName({required this.modelNameId, required this.modelName});

  factory CarModelName.fromJson(Map<String, dynamic> json) {
    return CarModelName(
      modelNameId: json['model_name_id'] ?? '',
      modelName: json['model_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'model_name_id': modelNameId, 'model_name': modelName};
  }
}

class CarType {
  final String typeId;
  final String typeName;

  CarType({required this.typeId, required this.typeName});

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      typeId: json['type_id'] ?? '',
      typeName: json['type_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'type_id': typeId, 'type_name': typeName};
  }
}

class CarBrand {
  final String brandId;
  final String brandName;

  CarBrand({required this.brandId, required this.brandName});

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      brandId: json['brand_id'] ?? '',
      brandName: json['brand_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'brand_id': brandId, 'brand_name': brandName};
  }
}

class Favorite {
  final int favId;
  final int userId;
  final ReviewModel carModel;

  Favorite({required this.favId, required this.userId, required this.carModel});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      favId: json['fav_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      carModel: ReviewModel.fromJson(json['car_model'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'fav_id': favId, 'user_id': userId, 'car_model': carModel.toJson()};
  }
}
