class LocationActiveModel {
  final int id;
  final int userId;
  final String location;
  final String latitude;
  final String longitude;
  final bool isActive;

  LocationActiveModel({
    required this.id,
    required this.userId,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.isActive,
  });

  factory LocationActiveModel.fromJson(Map<String, dynamic> json) {
    return LocationActiveModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      location: json['location'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      isActive: (json['is_active'] as int) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'is_active': isActive ? 1 : 0,
    };
  }
}

class ActiveLocationResponse {
  final String message;
  final LocationActiveModel data;

  ActiveLocationResponse({
    required this.message,
    required this.data,
  });

  factory ActiveLocationResponse.fromJson(Map<String, dynamic> json) {
    return ActiveLocationResponse(
      message: json['message'] as String,
      data: LocationActiveModel.fromJson(json['data']),
    );
  }
}
