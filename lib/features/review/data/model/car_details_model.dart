class CarDetailsModel {
  final String id;
  final CarAttributes attributes;
  final CarRelationship relationship;

  CarDetailsModel({
    required this.id,
    required this.attributes,
    required this.relationship,
  });

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) {
    return CarDetailsModel(
      id: json['id'] ?? '',
      attributes: CarAttributes.fromJson(json['attributes'] ?? {}),
      relationship: CarRelationship.fromJson(json['relationship'] ?? {}),
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
      year: json['year'] ?? '',
      price: json['price'] ?? '',
      engineType: json['engine_type'] ?? '',
      transmissionType: json['transmission_type'] ?? '',
      seatType: json['seat_type'] ?? '',
      seatsCount: json['seats_count'] ?? 0,
      acceleration: json['acceleration'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class CarRelationship {
  final ModelName modelName;
  final List<String> images;
  final CarType type;
  final CarBrand brand;
  final CarRatings ratings;

  CarRelationship({
    required this.modelName,
    required this.images,
    required this.type,
    required this.brand,
    required this.ratings,
  });

  factory CarRelationship.fromJson(Map<String, dynamic> json) {
    return CarRelationship(
      modelName: ModelName.fromJson(json['Model Names'] ?? {}),
      images: List<String>.from(json['Images'] ?? []),
      type: CarType.fromJson(json['Types'] ?? {}),
      brand: CarBrand.fromJson(json['Brand'] ?? {}),
      ratings: CarRatings.fromJson(json['Ratings'] ?? {}),
    );
  }
}

class ModelName {
  final String modelNameId;
  final String modelName;

  ModelName({required this.modelNameId, required this.modelName});

  factory ModelName.fromJson(Map<String, dynamic> json) {
    return ModelName(
      modelNameId: json['model_name_id'] ?? '',
      modelName: json['model_name'] ?? '',
    );
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
}

class CarBrand {
  final int brandId;
  final String brandName;

  CarBrand({required this.brandId, required this.brandName});

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      brandId: json['brand_id'] ?? 0,
      brandName: json['brand_name'] ?? '',
    );
  }
}

class CarRatings {
  final String averageRating;
  final int ratingsCount;
  final List<Review> reviews;

  CarRatings({
    required this.averageRating,
    required this.ratingsCount,
    required this.reviews,
  });

  factory CarRatings.fromJson(Map<String, dynamic> json) {
    return CarRatings(
      averageRating: json['average_rating'] ?? '0.0',
      ratingsCount: json['ratings_count'] ?? 0,
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Review {
  final int userId;
  final String userName;
  final String lastName;
  final String email;
  final int rating;
  final String review;

  Review({
    required this.userId,
    required this.userName,
    required this.lastName,
    required this.email,
    required this.rating,
    required this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'] ?? 0,
      userName: json['user_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      rating: json['rating'] ?? 0,
      review: json['review'] ?? '',
    );
  }
}
