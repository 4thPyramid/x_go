// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusResponse _$OrderStatusResponseFromJson(Map<String, dynamic> json) =>
    OrderStatusResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderStatusData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderStatusResponseToJson(
  OrderStatusResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

OrderStatusData _$OrderStatusDataFromJson(Map<String, dynamic> json) =>
    OrderStatusData(
      id: (json['id'] as num?)?.toInt(),
      paymentMethod: json['payment_method'] as String?,
      finalPrice: json['final_price'] as String?,
      modelName: json['model_name'] as String?,
      carModelYear: json['car_model_year'] as String?,
      carModelImage: json['car_model_image'] as String?,
      carPlateNumber: json['car_plate_number'] as String?,
      carColor: json['car_color'] as String?,
      userName: json['user_name'] as String?,
      userPhone: json['user_phone'] as String?,
      driverName: json['driver_name'] as String?,
      driverPhone: json['driver_phone'] as String?,
      location: json['location'] as String?,
      ratings: json['Ratings'] == null
          ? null
          : Ratings.fromJson(json['Ratings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderStatusDataToJson(OrderStatusData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payment_method': instance.paymentMethod,
      'final_price': instance.finalPrice,
      'model_name': instance.modelName,
      'car_model_year': instance.carModelYear,
      'car_model_image': instance.carModelImage,
      'Ratings': instance.ratings,
      'car_plate_number': instance.carPlateNumber,
      'car_color': instance.carColor,
      'user_name': instance.userName,
      'user_phone': instance.userPhone,
      'driver_name': instance.driverName,
      'driver_phone': instance.driverPhone,
      'location': instance.location,
    };

Ratings _$RatingsFromJson(Map<String, dynamic> json) => Ratings(
  averageRating: json['average_rating'] as String?,
  ratingsCount: (json['ratings_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$RatingsToJson(Ratings instance) => <String, dynamic>{
  'average_rating': instance.averageRating,
  'ratings_count': instance.ratingsCount,
};
