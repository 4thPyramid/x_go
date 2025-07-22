//this is a model class for accepted orders response in a delivery application
//it contains the response message and a list of accepted orders
//it also contains a nested AcceptedOrder class that represents each accepted order
//it also contains a nested Ratings class that represents the ratings of the accepted order
//it also contains a method to convert the AcceptedOrder to a domain entity
//it uses json_serializable for JSON serialization and deserialization
import 'package:json_annotation/json_annotation.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';
part 'accepted_order_response_model.g.dart';

@JsonSerializable()
class AcceptedOrderResponse {
  final String message;
  final List<AcceptedOrder> data;

  AcceptedOrderResponse({required this.message, required this.data});

  factory AcceptedOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderResponseToJson(this);
}

@JsonSerializable()
class AcceptedOrder {
  final int id;

  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  final String status;

  @JsonKey(name: 'payment_method')
  final String paymentMethod;

  @JsonKey(name: 'final_price')
  final String finalPrice;

  @JsonKey(name: 'car_model_id')
  final int carModelId;

  @JsonKey(name: 'model_name')
  final String modelName;

  @JsonKey(name: 'car_model_year')
  final String carModelYear;

  @JsonKey(name: 'car_model_image')
  final String carModelImage;

  @JsonKey(name: 'brand_name')
  final String brandName;

  @JsonKey(name: 'car_plate_number')
  final String carPlateNumber;

  @JsonKey(name: 'car_color')
  final String carColor;

  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'user_email')
  final String userEmail;

  @JsonKey(name: 'user_phone')
  final String userPhone;

  @JsonKey(name: 'driver_name')
  final String driverName;

  @JsonKey(name: 'driver_email')
  final String driverEmail;

  @JsonKey(name: 'driver_phone')
  final String driverPhone;

  final String location;
  final String latitude;
  final String longitude;

  // Ratings fields are nested
  @JsonKey(name: 'Ratings')
  final Ratings? ratings;

  AcceptedOrder({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.paymentMethod,
    required this.finalPrice,
    required this.carModelId,
    required this.modelName,
    required this.carModelYear,
    required this.carModelImage,
    required this.brandName,
    required this.carPlateNumber,
    required this.carColor,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.driverName,
    required this.driverEmail,
    required this.driverPhone,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.ratings,
  });

  factory AcceptedOrder.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptedOrderToJson(this);
  // Convert to domain entity
  AcceptedOrderEntity toEntity() {
    return AcceptedOrderEntity(
      id: id,
      startDate: startDate,
      endDate: endDate,
      status: status,
      paymentMethod: paymentMethod,
      finalPrice: finalPrice,
      carModelId: carModelId,
      modelName: modelName,
      carModelYear: carModelYear,
      carModelImage: carModelImage,
      brandName: brandName,
      carPlateNumber: carPlateNumber,
      carColor: carColor,
      userName: userName,
      userEmail: userEmail,
      userPhone: userPhone,
      driverName: driverName,
      driverEmail: driverEmail,
      driverPhone: driverPhone,
      location: location,
      latitude: latitude,
      longitude: longitude,
      averageRating: ratings?.averageRating,
      ratingsCount: ratings?.ratingsCount,
    );
  }
}

@JsonSerializable()
class Ratings {
  @JsonKey(name: 'average_rating')
  final String averageRating;

  @JsonKey(name: 'ratings_count')
  final int ratingsCount;

  Ratings({required this.averageRating, required this.ratingsCount});

  factory Ratings.fromJson(Map<String, dynamic> json) =>
      _$RatingsFromJson(json);

  Map<String, dynamic> toJson() => _$RatingsToJson(this);
}
