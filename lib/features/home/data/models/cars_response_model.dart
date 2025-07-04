import 'package:json_annotation/json_annotation.dart';
import 'package:x_go/features/home/data/models/car_model.dart';

part 'cars_response_model.g.dart';

@JsonSerializable()
class CarsResponseModel {
  @JsonKey(name: 'data')
  final List<CarModel> data;

  const CarsResponseModel({
    required this.data,
  });

  factory CarsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CarsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarsResponseModelToJson(this);
}
