// features/Details/data/models/car_detail_model.dart
class CarDetailModel {
  final String id;
  final CarDetailAttributes attributes;
  final CarDetailRelationship relationship;

  CarDetailModel({
    required this.id,
    required this.attributes,
    required this.relationship,
  });

  factory CarDetailModel.fromJson(Map<String, dynamic> json) {
    try {
      return CarDetailModel(
        id: json['id']?.toString() ?? '',
        attributes:
            json['attributes'] != null &&
                json['attributes'] is Map<String, dynamic>
            ? CarDetailAttributes.fromJson(
                json['attributes'] as Map<String, dynamic>,
              )
            : CarDetailAttributes(
                year: '',
                price: '',
                engineType: '',
                transmissionType: '',
                seatType: '',
                seatsCount: 0,
                acceleration: '',
                image: '',
              ),
        relationship:
            json['relationship'] != null &&
                json['relationship'] is Map<String, dynamic>
            ? CarDetailRelationship.fromJson(
                json['relationship'] as Map<String, dynamic>,
              )
            : CarDetailRelationship(
                modelName: ModelName(id: '', name: ''),
                images: [],
                type: CarType(id: '', name: ''),
                brand: Brand(id: 0, name: ''),
                ratings: Ratings(
                  averageRating: '0.0',
                  ratingsCount: 0,
                  reviews: [],
                ),
              ),
      );
    } catch (e) {
      print('Error in CarDetailModel.fromJson: $e');
      // Return a minimal valid model as fallback
      return CarDetailModel(
        id: json['id']?.toString() ?? '',
        attributes: CarDetailAttributes(
          year: '',
          price: '',
          engineType: '',
          transmissionType: '',
          seatType: '',
          seatsCount: 0,
          acceleration: '',
          image: '',
        ),
        relationship: CarDetailRelationship(
          modelName: ModelName(id: '', name: ''),
          images: [],
          type: CarType(id: '', name: ''),
          brand: Brand(id: 0, name: ''),
          ratings: Ratings(averageRating: '0.0', ratingsCount: 0, reviews: []),
        ),
      );
    }
  }
}

class CarDetailAttributes {
  final String year;
  final String price;
  final String engineType;
  final String transmissionType;
  final String seatType;
  final int seatsCount;
  final String acceleration;
  final String image;

  CarDetailAttributes({
    required this.year,
    required this.price,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
    required this.seatsCount,
    required this.acceleration,
    required this.image,
  });

  factory CarDetailAttributes.fromJson(Map<String, dynamic> json) {
    return CarDetailAttributes(
      year: json['year']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      engineType: json['engine_type']?.toString() ?? '',
      transmissionType: json['transmission_type']?.toString() ?? '',
      seatType: json['seat_type']?.toString() ?? '',
      seatsCount: json['seats_count'] as int? ?? 0,
      acceleration: json['acceleration']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}

class CarDetailRelationship {
  final ModelName modelName;
  final List<String> images;
  final CarType type;
  final Brand brand;
  final Ratings ratings;

  CarDetailRelationship({
    required this.modelName,
    required this.images,
    required this.type,
    required this.brand,
    required this.ratings,
  });

  factory CarDetailRelationship.fromJson(Map<String, dynamic> json) {
    try {
      List<String> imageList = [];

      // Handle images safely
      if (json['Images'] != null) {
        if (json['Images'] is List) {
          final imageData = json['Images'] as List;
          imageList = imageData
              .map((img) => img?.toString() ?? '')
              .where((img) => img.isNotEmpty)
              .toList();
        } else {
          print(
            'Warning: Images field is not a List: ${json['Images'].runtimeType}',
          );
        }
      }

      return CarDetailRelationship(
        modelName:
            json['Model Names'] != null &&
                json['Model Names'] is Map<String, dynamic>
            ? ModelName.fromJson(json['Model Names'] as Map<String, dynamic>)
            : ModelName(id: '', name: ''),
        images: imageList,
        type: json['Types'] != null && json['Types'] is Map<String, dynamic>
            ? CarType.fromJson(json['Types'] as Map<String, dynamic>)
            : CarType(id: '', name: ''),
        brand: json['Brand'] != null && json['Brand'] is Map<String, dynamic>
            ? Brand.fromJson(json['Brand'] as Map<String, dynamic>)
            : Brand(id: 0, name: ''),
        ratings:
            json['Ratings'] != null && json['Ratings'] is Map<String, dynamic>
            ? Ratings.fromJson(json['Ratings'] as Map<String, dynamic>)
            : Ratings(averageRating: '0.0', ratingsCount: 0, reviews: []),
      );
    } catch (e) {
      print('Error in CarDetailRelationship.fromJson: $e');
      // Return a fallback object if parsing fails
      return CarDetailRelationship(
        modelName: ModelName(id: '', name: ''),
        images: [],
        type: CarType(id: '', name: ''),
        brand: Brand(id: 0, name: ''),
        ratings: Ratings(averageRating: '0.0', ratingsCount: 0, reviews: []),
      );
    }
  }
}

class ModelName {
  final String id;
  final String name;

  ModelName({required this.id, required this.name});

  factory ModelName.fromJson(Map<String, dynamic> json) {
    return ModelName(
      id: json['model_name_id']?.toString() ?? '',
      name: json['model_name']?.toString() ?? '',
    );
  }
}

class CarType {
  final String id;
  final String name;

  CarType({required this.id, required this.name});

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      id: json['type_id']?.toString() ?? '',
      name: json['type_name']?.toString() ?? '',
    );
  }
}

class Brand {
  final int id;
  final String name;

  Brand({required this.id, required this.name});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['brand_id'] as int? ?? 0,
      name: json['brand_name']?.toString() ?? '',
    );
  }
}

class Ratings {
  final String averageRating;
  final int ratingsCount;
  final List<Review> reviews;

  Ratings({
    required this.averageRating,
    required this.ratingsCount,
    required this.reviews,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    List<Review> reviewList = [];

    // Safely handle the reviews list
    if (json['reviews'] != null) {
      try {
        final reviewsData = json['reviews'] as List?;
        if (reviewsData != null) {
          reviewList = reviewsData.map((review) {
            if (review is Map<String, dynamic>) {
              return Review.fromJson(review);
            } else {
              // Return a default review if the data is not in expected format
              return Review(
                userId: 0,
                userName: '',
                lastName: '',
                email: '',
                rating: 0,
                review: '',
              );
            }
          }).toList();
        }
      } catch (e) {
        print('Error parsing reviews: $e');
        // Return empty list if there's an error
      }
    }

    return Ratings(
      averageRating: json['average_rating']?.toString() ?? '0.0',
      ratingsCount: json['ratings_count'] is int
          ? json['ratings_count'] as int
          : 0,
      reviews: reviewList,
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
      userId: json['user_id'] is int ? json['user_id'] as int : 0,
      userName: json['user_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      rating: json['rating'] is int ? json['rating'] as int : 0,
      review: json['review']?.toString() ?? '',
    );
  }
}

class CarDetailResponse {
  final CarDetailModel data;

  CarDetailResponse({required this.data});

  factory CarDetailResponse.fromJson(Map<String, dynamic> json) {
    try {
      if (json['data'] == null) {
        throw Exception("Response does not contain 'data' field");
      }

      final dataMap = json['data'];
      if (dataMap is! Map<String, dynamic>) {
        throw Exception("'data' field is not a valid Map");
      }

      return CarDetailResponse(data: CarDetailModel.fromJson(dataMap));
    } catch (e) {
      print('Error in CarDetailResponse.fromJson: $e');
      // Create a minimal valid response with empty data
      return CarDetailResponse(
        data: CarDetailModel(
          id: '',
          attributes: CarDetailAttributes(
            year: '',
            price: '',
            engineType: '',
            transmissionType: '',
            seatType: '',
            seatsCount: 0,
            acceleration: '',
            image: '',
          ),
          relationship: CarDetailRelationship(
            modelName: ModelName(id: '', name: ''),
            images: [],
            type: CarType(id: '', name: ''),
            brand: Brand(id: 0, name: ''),
            ratings: Ratings(
              averageRating: '0.0',
              ratingsCount: 0,
              reviews: [],
            ),
          ),
        ),
      );
    }
  }
}
