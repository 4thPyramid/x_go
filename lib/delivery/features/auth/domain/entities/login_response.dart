import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String key;
  final String message;
  final LoginData data;

  const LoginResponse({
    required this.key,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [key, message, data];
}

class LoginData extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String token;

  const LoginData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.token,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, phone, token];
}
