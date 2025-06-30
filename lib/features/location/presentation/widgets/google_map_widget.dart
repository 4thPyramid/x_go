import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final LatLng initialLocation;
  final Function(LatLng) onTap;
  final Set<Marker> markers;
  const GoogleMapWidget({
    super.key,
    required this.initialLocation,
    required this.onTap,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(zoom: 8, target: initialLocation),
      onMapCreated: (GoogleMapController controller) {},
      onTap: onTap,
      markers: markers,
    );
  }
}
