import '../../domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    required String key,
    required String message,
    required UserDataModel data,
  }) : super(
          key: key,
          message: message,
          data: data,
        );

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      key: json['key'],
      message: json['msg'],
      data: UserDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'msg': message,
      'data': (data as UserDataModel).toJson(),
    };
  }
}

class UserDataModel extends UserData {
  const UserDataModel({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String token,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          token: token,
        );

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
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
