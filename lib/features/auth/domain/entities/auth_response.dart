import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String key;
  final String message;
  final UserData data;

  const AuthResponse({
    required this.key,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [key, message, data];
}

class UserData extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String token;

  const UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.token,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, phone, token];
}
