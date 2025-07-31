// locatin_services_home.dart
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationHomeDeliveryService {
  Future<String> getReadableLocation();
}

class LocationHomeDeliveryServiceImpl implements LocationHomeDeliveryService {
  @override
  Future<String> getReadableLocation() async {
    final position = await Geolocator.getCurrentPosition();

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemarks.first;
    return '${place.country}، ${place.administrativeArea}، ${place.locality}، ${place.street}';
  }
}
