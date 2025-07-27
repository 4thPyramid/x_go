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
      favId: json['fav_id'] is int
          ? json['fav_id']
          : int.tryParse(json['fav_id'].toString()) ?? 0,
      userId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse(json['user_id'].toString()) ?? 0,
      carModel: CarModel.fromJson(json['car_model']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'fav_id': favId, 'user_id': userId, 'car_model': carModel.toJson()};
  }
}
