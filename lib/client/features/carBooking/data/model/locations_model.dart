class LocationsModel {
  final String? message;
  final List<LocationData>? data;

  LocationsModel({this.message, this.data});

  factory LocationsModel.fromJson(Map<String, dynamic> json) {
    return LocationsModel(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => LocationData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class LocationData {
  final int? id;
  final int? userId;
  final String? location;
  final String? latitude;
  final String? longitude;
  final int? isActive;

  LocationData({
    this.id,
    this.userId,
    this.location,
    this.latitude,
    this.longitude,
    this.isActive,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      location: json['location'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      isActive: json['is_active'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'is_active': isActive,
    };
  }
}
