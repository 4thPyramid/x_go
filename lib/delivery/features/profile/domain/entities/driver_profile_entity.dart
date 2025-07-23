class DriverProfileEntity {
  final int id;
  final String? name;
  final String? email;
  final String? phone;
  final List<LocationEntity> locations;
  final List<BookingEntity> bookings;

  DriverProfileEntity({
    required this.id,
    this.name,
    this.email,
    this.phone,
    required this.locations,
    required this.bookings,
  });
}

class LocationEntity {
  final int id;
  final String? location;

  LocationEntity({required this.id, this.location});
}

class BookingEntity {
  final int id;
  final String? createdAt;

  BookingEntity({required this.id, this.createdAt});
}
