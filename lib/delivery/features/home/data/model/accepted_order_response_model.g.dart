// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accepted_order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptedOrderResponse _$AcceptedOrderResponseFromJson(
  Map<String, dynamic> json,
) => AcceptedOrderResponse(
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => AcceptedOrder.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AcceptedOrderResponseToJson(
  AcceptedOrderResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

AcceptedOrder _$AcceptedOrderFromJson(Map<String, dynamic> json) =>
    AcceptedOrder(
      id: (json['id'] as num).toInt(),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      status: json['status'] as String,
      paymentMethod: json['payment_method'] as String,
      finalPrice: json['final_price'] as String,
      carModelId: (json['car_model_id'] as num).toInt(),
      modelName: json['model_name'] as String,
      carModelYear: json['car_model_year'] as String,
      carModelImage: json['car_model_image'] as String,
      brandName: json['brand_name'] as String,
      carPlateNumber: json['car_plate_number'] as String,
      carColor: json['car_color'] as String,
      userName: json['user_name'] as String,
      userEmail: json['user_email'] as String,
      userPhone: json['user_phone'] as String,
      driverName: json['driver_name'] as String,
      driverEmail: json['driver_email'] as String,
      driverPhone: json['driver_phone'] as String,
      location: json['location'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      ratings: json['Ratings'] == null
          ? null
          : Ratings.fromJson(json['Ratings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptedOrderToJson(AcceptedOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'status': instance.status,
      'payment_method': instance.paymentMethod,
      'final_price': instance.finalPrice,
      'car_model_id': instance.carModelId,
      'model_name': instance.modelName,
      'car_model_year': instance.carModelYear,
      'car_model_image': instance.carModelImage,
      'brand_name': instance.brandName,
      'car_plate_number': instance.carPlateNumber,
      'car_color': instance.carColor,
      'user_name': instance.userName,
      'user_email': instance.userEmail,
      'user_phone': instance.userPhone,
      'driver_name': instance.driverName,
      'driver_email': instance.driverEmail,
      'driver_phone': instance.driverPhone,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'Ratings': instance.ratings,
    };

Ratings _$RatingsFromJson(Map<String, dynamic> json) => Ratings(
  averageRating: json['average_rating'] as String,
  ratingsCount: (json['ratings_count'] as num).toInt(),
);

Map<String, dynamic> _$RatingsToJson(Ratings instance) => <String, dynamic>{
  'average_rating': instance.averageRating,
  'ratings_count': instance.ratingsCount,
};
