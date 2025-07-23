import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/delivery/features/orderDetails/data/models/booking_model.dart';

class LocationWidget extends StatefulWidget {
  final LocationModel? location;
  
  const LocationWidget({
    super.key,
    this.location,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  GoogleMapController? _mapController;

  // Default location (Cairo) في حالة عدم توفر موقع
  LatLng get _defaultLocation => const LatLng(30.033333, 31.233334);

  LatLng get _currentLocation {
    if (widget.location != null) {
      final lat = double.tryParse(widget.location!.latitude);
      final lng = double.tryParse(widget.location!.longitude);
      
      if (lat != null && lng != null) {
        return LatLng(lat, lng);
      }
    }
    return _defaultLocation;
  }

  Set<Marker> get _markers {
    return {
      Marker(
        markerId: const MarkerId('pickup_location'),
        position: _currentLocation,
        infoWindow: InfoWindow(
          title: 'موقع الاستلام',
          snippet: widget.location?.address ?? 'الموقع الحالي',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };
  }

  void _animateToLocation() {
    if (_mapController == null) return;
    
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentLocation,
          zoom: 15.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentLocation,
            zoom: 15.0,
          ),
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            // تأخير بسيط للتأكد من تحميل الخريطة
            Future.delayed(
              const Duration(milliseconds: 500),
              _animateToLocation,
            );
          },
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          mapToolbarEnabled: false,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          tiltGesturesEnabled: true,
        ),
      ),
    );
  }
}