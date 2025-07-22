import 'package:json_annotation/json_annotation.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

part 'order_status_model_response.g.dart';

@JsonSerializable()
class OrderStatusResponse {
  final String? message;
  final List<OrderStatusData>? data;

  OrderStatusResponse({this.message, this.data});

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusResponseToJson(this);
}

@JsonSerializable()
class OrderStatusData {
  final int? id;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @JsonKey(name: 'final_price')
  final String? finalPrice;

  @JsonKey(name: 'model_name')
  final String? modelName;

  @JsonKey(name: 'car_model_year')
  final String? carModelYear;

  @JsonKey(name: 'car_model_image')
  final String? carModelImage;

  @JsonKey(name: 'Ratings')
  final Ratings? ratings;

  @JsonKey(name: 'car_plate_number')
  final String? carPlateNumber;

  @JsonKey(name: 'car_color')
  final String? carColor;

  @JsonKey(name: 'user_name')
  final String? userName;

  @JsonKey(name: 'user_phone')
  final String? userPhone;

  @JsonKey(name: 'driver_name')
  final String? driverName;

  @JsonKey(name: 'driver_phone')
  final String? driverPhone;

  final String? location;

  OrderStatusData({
    this.id,
    this.paymentMethod,
    this.finalPrice,
    this.modelName,
    this.carModelYear,
    this.carModelImage,
    this.carPlateNumber,
    this.carColor,
    this.userName,
    this.userPhone,
    this.driverName,
    this.driverPhone,
    this.location,
    this.ratings,
  });

  factory OrderStatusData.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusDataToJson(this);

  OrderStatusEntity toEntity() {
    return OrderStatusEntity(
      id: id ?? 0,
      paymentMethod: paymentMethod ?? '',
      finalPrice: finalPrice ?? '',
      modelName: modelName ?? '',
      carModelYear: carModelYear ?? '',
      carModelImage: carModelImage ?? '',
      carPlateNumber: carPlateNumber ?? '',
      carColor: carColor ?? '',
      userName: userName ?? '',
      userPhone: userPhone ?? '',
      driverName: driverName ?? '',
      driverPhone: driverPhone ?? '',
      location: location ?? '',
      averageRating: ratings?.averageRating,
      ratingsCount: ratings?.ratingsCount,
    );
  }
}

@JsonSerializable()
class Ratings {
  @JsonKey(name: 'average_rating')
  final String? averageRating;

  @JsonKey(name: 'ratings_count')
  final int? ratingsCount;

  Ratings({this.averageRating, this.ratingsCount});

  factory Ratings.fromJson(Map<String, dynamic> json) =>
      _$RatingsFromJson(json);

  Map<String, dynamic> toJson() => _$RatingsToJson(this);
}
