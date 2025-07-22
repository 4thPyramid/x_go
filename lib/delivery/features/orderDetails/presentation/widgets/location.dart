import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  GoogleMapController? _mapController;

  final LatLng point1 = const LatLng(30.033333, 31.233334); // Cairo
  final LatLng point2 = const LatLng(29.9792, 31.1342);     // Giza Pyramids

  Set<Marker> get _markers => {
        Marker(
          markerId: const MarkerId('point1'),
          position: point1,
          infoWindow: const InfoWindow(title: 'Cairo'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
        Marker(
          markerId: const MarkerId('point2'),
          position: point2,
          infoWindow: const InfoWindow(title: 'Giza Pyramids'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };

  void _fitBounds() {
    if (_mapController == null) return;

    final bounds = LatLngBounds(
      southwest: LatLng(
        point1.latitude < point2.latitude ? point1.latitude : point2.latitude,
        point1.longitude < point2.longitude ? point1.longitude : point2.longitude,
      ),
      northeast: LatLng(
        point1.latitude > point2.latitude ? point1.latitude : point2.latitude,
        point1.longitude > point2.longitude ? point1.longitude : point2.longitude,
      ),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // استخدم 300.h لو كنت تستخدم ScreenUtil
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: point1,
          zoom: 5,
        ),
        markers: _markers,
        onMapCreated: (controller) {
          _mapController = controller;
          Future.delayed(const Duration(milliseconds: 300), _fitBounds);
        },
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        compassEnabled: false,
      ),
    );
  }
}
