class BookingModel {
  final String? message;
  final BookingData? data;

  BookingModel({this.message, this.data});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      message: json['message'],
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}

class BookingData {
  final Booking? booking;

  BookingData({this.booking});

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      booking: json['booking'] != null
          ? Booking.fromJson(json['booking'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'booking': booking?.toJson()};
  }
}

class Booking {
  final String? startDate;
  final String? endDate;
  final int? finalPrice;
  final int? userId;
  final int? carmodelId;
  final String? additionalDriver;
  final int? id;
  final int? locationId;
  final Location? location;
  final User? user;
  final CarModel? carmodel;

  Booking({
    this.startDate,
    this.endDate,
    this.finalPrice,
    this.userId,
    this.carmodelId,
    this.additionalDriver,
    this.id,
    this.locationId,
    this.location,
    this.user,
    this.carmodel,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      startDate: json['start_date'],
      endDate: json['end_date'],
      finalPrice: json['final_price'],
      userId: json['user_id'],
      carmodelId: json['carmodel_id'],
      additionalDriver: json['additional_driver'],
      id: json['id'],
      locationId: json['location_id'],
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      carmodel: json['carmodel'] != null
          ? CarModel.fromJson(json['carmodel'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'final_price': finalPrice,
      'user_id': userId,
      'carmodel_id': carmodelId,
      'additional_driver': additionalDriver,
      'id': id,
      'location_id': locationId,
      'location': location?.toJson(),
      'user': user?.toJson(),
      'carmodel': carmodel?.toJson(),
    };
  }
}

class Location {
  final int? id;
  final int? userId;
  final String? location;
  final String? latitude;
  final String? longitude;
  final int? isActive;

  Location({
    this.id,
    this.userId,
    this.location,
    this.latitude,
    this.longitude,
    this.isActive,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      userId: json['user_id'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isActive: json['is_active'],
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

class User {
  final int? id;
  final String? name;
  final String? lastName;
  final String? image;
  final String? email;
  final String? phone;

  User({this.id, this.name, this.lastName, this.image, this.email, this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
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
    };
  }
}

class CarModel {
  final int? id;
  final String? name;
  final String? year;
  final int? count;
  final String? price;
  final int? typeId;
  final String? image;
  final String? engineType;
  final String? transmissionType;
  final String? seatType;
  final int? seatsCount;
  final String? acceleration;

  CarModel({
    this.id,
    this.name,
    this.year,
    this.count,
    this.price,
    this.typeId,
    this.image,
    this.engineType,
    this.transmissionType,
    this.seatType,
    this.seatsCount,
    this.acceleration,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      count: json['count'],
      price: json['price'],
      typeId: json['type_id'],
      image: json['image'],
      engineType: json['engine_type'],
      transmissionType: json['transmission_type'],
      seatType: json['seat_type'],
      seatsCount: json['seats_count'],
      acceleration: json['acceleration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year': year,
      'count': count,
      'price': price,
      'type_id': typeId,
      'image': image,
      'engine_type': engineType,
      'transmission_type': transmissionType,
      'seat_type': seatType,
      'seats_count': seatsCount,
      'acceleration': acceleration,
    };
  }
}
