import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final LatLng initialLocation;
  final Function(LatLng) onTap;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;
  const GoogleMapWidget({
    super.key,
    required this.initialLocation,
    required this.onTap,
    required this.markers,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(zoom: 10, target: initialLocation),
      onMapCreated: onMapCreated,
      onTap: onTap,
      markers: markers,
    );
  }
}
