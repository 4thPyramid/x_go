import 'package:x_go/features/auth/domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({
    required super.key,
    required super.message,
    required super.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      key: json['key'],
      message: json['msg'],
      data: LoginDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'msg': message,
      'data': (data as LoginDataModel).toJson(),
    };
  }
}

class LoginDataModel extends LoginData {
  const LoginDataModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.token,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      token: json['token'],
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
