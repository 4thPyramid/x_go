class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String? image;
  final String email;
  final String phone;
  final String? location;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    this.image,
    required this.email,
    required this.phone,
    this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
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
    };
  }
}
