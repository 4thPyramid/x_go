
import 'package:x_go/features/auth/data/models/login_response_model.dart';

class GetProfileResponse {
  final String message;
  final UserModel data;

  GetProfileResponse({
    required this.message,
    required this.data,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      message: json['message'],
      data: UserModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}
