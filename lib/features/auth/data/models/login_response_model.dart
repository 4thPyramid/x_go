class LoginResponseModel {
  final UserModel user;
  final String token;

  LoginResponseModel({required this.user, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'token': token};
  }
}

class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String? image;
  final String email;
  final String phone;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? emailVerifiedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    this.image,
    required this.email,
    required this.phone,
    this.location,
    this.latitude,
    this.longitude,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      image: json['image'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      emailVerifiedAt: json['email_verified_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'image': image,
      'email': email,
      'phone': phone,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'email_verified_at': emailVerifiedAt,
    };
  }
}
