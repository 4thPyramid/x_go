
import 'package:x_go/delivery/features/auth/domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    required super.key,
    required super.message,
    required UserDataModel super.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      key: json['token'] ?? '',
      message: json['message'] ?? '',
      data: UserDataModel.fromJson(json['driver'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'message': message,
      'driver': (data as UserDataModel).toJson(),
    };
  }
}
class UserDataModel extends UserData {
  const UserDataModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }
}
