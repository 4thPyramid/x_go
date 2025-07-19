import 'package:x_go/client/features/home/data/models/car_model.dart';

class FavoriteModel {
  final int favId;
  final int userId;
  final CarModel carModel;

  FavoriteModel({
    required this.favId,
    required this.userId,
    required this.carModel,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favId: json['fav_id'],
      userId: json['user_id'],
      carModel: CarModel.fromJson(json['car_model']),
    );
  }
}
