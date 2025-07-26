import 'package:equatable/equatable.dart';
import 'package:x_go/delivery/features/orderDetails/domain/entities/booking_entity.dart';

class BookingModel extends Equatable {
  final int id;
  final String startDate;
  final String endDate;
  final String finalPrice;
  final String status;
  final int additionalDriver;
  final String paymentMethod;
  final String? paymentStatus;
  final String? transactionId;
  final CarModel carModel;
  final LocationModel? location;
  final UserModel user;
  final CarData car;

  const BookingModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.finalPrice,
    required this.status,
    required this.additionalDriver,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.transactionId,
    required this.carModel,
    required this.location,
    required this.user,
    required this.car,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      finalPrice: json['final_price'],
      status: json['status'],
      additionalDriver: json['additional_driver'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      transactionId: json['transaction_id'],
      carModel: CarModel.fromJson(json['car_model']),
      location: json['location'] != null ? LocationModel.fromJson(json['location']) : null,
      user: UserModel.fromJson(json['user']),
      car: CarData.fromJson(json['car']),
    );
  }

  @override
  List<Object?> get props => [id, startDate, endDate, finalPrice, status];
}
class CarModel {
  final String id;
  final CarAttributes attributes;
  final CarRelationships relationship;

  CarModel({required this.id, required this.attributes, required this.relationship});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      attributes: CarAttributes.fromJson(json['attributes']),
      relationship: CarRelationships.fromJson(json['relationship']),
    );
  }
}

class CarAttributes {
  final String year;
  final String price;
  final String engineType;
  final String transmissionType;
  final String seatType;
  final int seatsCount;
  final String acceleration;
  final String image;

  CarAttributes({
    required this.year,
    required this.price,
    required this.engineType,
    required this.transmissionType,
    required this.seatType,
    required this.seatsCount,
    required this.acceleration,
    required this.image,
  });

  factory CarAttributes.fromJson(Map<String, dynamic> json) {
    return CarAttributes(
      year: json['year'],
      price: json['price'],
      engineType: json['engine_type'],
      transmissionType: json['transmission_type'],
      seatType: json['seat_type'],
      seatsCount: json['seats_count'],
      acceleration: json['acceleration'],
      image: json['image'],
    );
  }
}

class CarRelationships {
  final ModelName modelName;
  final TypeName type;
  final Brand brand;

  CarRelationships({required this.modelName, required this.type, required this.brand});

  factory CarRelationships.fromJson(Map<String, dynamic> json) {
    return CarRelationships(
      modelName: ModelName.fromJson(json['Model Names']),
      type: TypeName.fromJson(json['Types']),
      brand: Brand.fromJson(json['Brand']),
    );
  }
}

class ModelName {
  final String modelName;

  ModelName({required this.modelName});

  factory ModelName.fromJson(Map<String, dynamic> json) {
    return ModelName(modelName: json['model_name']);
  }
}

class TypeName {
  final String typeName;

  TypeName({required this.typeName});

  factory TypeName.fromJson(Map<String, dynamic> json) {
    return TypeName(typeName: json['type_name']);
  }
}

class Brand {
  final String brandName;

  Brand({required this.brandName});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(brandName: json['brand_name']);
  }
}
class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String? image;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.image,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
class CarData {
  final int id;
  final int carmodelId;
  final String plateNumber;
  final String status;
  final String? image;
  final String color;

  CarData({
    required this.id,
    required this.carmodelId,
    required this.plateNumber,
    required this.status,
    required this.image,
    required this.color,
  });

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(
      id: json['id'],
      carmodelId: json['carmodel_id'],
      plateNumber: json['plate_number'],
      status: json['status'],
      image: json['image'],
      color: json['color'],
    );
  }
}
class LocationModel {
  final String latitude;
  final String longitude;
  final String address;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      address: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'location': address,
    };
  }
}
class DriverAttributes {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String latitude;
  final String longitude;

  DriverAttributes({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  factory DriverAttributes.fromJson(Map<String, dynamic> json) {
    return DriverAttributes(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}


extension BookingModelMapper on BookingModel {
  BookingEntity toEntity() {
    return BookingEntity(
      id: id,

      startDate: startDate,
      endDate: endDate,
      finalPrice: finalPrice,
      status: status,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      transactionId: transactionId,
      carModel: carModel,
      user: user,
      location: location,

      car: CarModelSimple(
        id: car.id,
        carmodelId: car.carmodelId,
        plateNumber: car.plateNumber,
        status: car.status,
        image: car.image,
        color: car.color,
      ),
    );
  }
}

// لازم تعرف CarModelSimple لأنك تستخدمه في الـ entity
class CarModelSimple {
  final int id;
  final int carmodelId;
  final String plateNumber;
  final String status;
  final String? image;
  final String color;

  CarModelSimple({
    required this.id,
    required this.carmodelId,
    required this.plateNumber,
    required this.status,
    required this.image,
    required this.color,
  });
}
