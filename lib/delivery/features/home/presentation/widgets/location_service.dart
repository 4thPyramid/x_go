/*// lib/core/services/location_service.dart
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<String> getCurrentCityAndCountry() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return 'الموقع غير مفعل';

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return 'تم رفض الإذن';
    }

    if (permission == LocationPermission.deniedForever) {
      return 'إذن الموقع مرفوض نهائيًا';
    }

    final position = await Geolocator.getCurrentPosition();
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemarks.first;
    return '${place.locality ?? ''}, ${place.country ?? ''}';
  }
}
*/
