import 'package:json_annotation/json_annotation.dart';

part 'driver_update_request.g.dart';

@JsonSerializable()
class DriverUpdateRequest {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  DriverUpdateRequest({this.name, this.email, this.phone});

  Map<String, dynamic> toJson() => _$DriverUpdateRequestToJson(this);
}
