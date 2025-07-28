import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:x_go/core/services/google_map_service.dart';
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
  LatLng? _currentLocation;
  bool _isLoadingLocation = true;
  String? _locationError;
  final LocationService _locationService = LocationService();

  static const LatLng _defaultCurrentLocation = LatLng(30.033333, 31.233334); // Cairo

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoadingLocation = true;
        _locationError = null;
      });

      Position? lastPosition = await _locationService.getLastKnownPosition();
      if (lastPosition != null) {
        setState(() {
          _currentLocation = LatLng(lastPosition.latitude, lastPosition.longitude);
        });
      }

      Position? position = await _locationService.getCurrentPosition();

      if (position != null) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _isLoadingLocation = false;
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          _animateToShowBothLocations();
        });
      } else {
        setState(() {
          _currentLocation = _defaultCurrentLocation;
          _isLoadingLocation = false;
          _locationError = 'لم يتم الحصول على الموقع';
        });
      }
    } catch (e) {
      setState(() {
        _currentLocation = _defaultCurrentLocation;
        _isLoadingLocation = false;
        _locationError = 'خطأ في الحصول على الموقع';
      });
    }
  }

  LatLng get _effectiveCurrentLocation => _currentLocation ?? _defaultCurrentLocation;

  LatLng? get _destinationLocation {
    if (widget.location != null &&
        widget.location!.latitude.isNotEmpty &&
        widget.location!.longitude.isNotEmpty) {
      final lat = double.tryParse(widget.location!.latitude);
      final lng = double.tryParse(widget.location!.longitude);

      if (lat != null &&
          lng != null &&
          lat >= -90 &&
          lat <= 90 &&
          lng >= -180 &&
          lng <= 180) {
        return LatLng(lat, lng);
      }
    }
    return null;
  }

  bool get _isUsingDefaultCurrent => _currentLocation == null || _currentLocation == _defaultCurrentLocation;

  Set<Marker> get _markers {
    if (_destinationLocation == null) return {};

    return {
      Marker(
        markerId: const MarkerId('current_location'),
        position: _effectiveCurrentLocation,
        infoWindow: InfoWindow(
          title: _isUsingDefaultCurrent ? 'نقطة البداية (افتراضية)' : 'نقطة البداية',
          snippet: _isUsingDefaultCurrent ? 'الموقع الافتراضي' : 'موقعك الحالي - نقطة البداية',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _isUsingDefaultCurrent ? BitmapDescriptor.hueOrange : BitmapDescriptor.hueGreen,
        ),
      ),
      Marker(
        markerId: const MarkerId('destination_location'),
        position: _destinationLocation!,
        infoWindow: InfoWindow(
          title: 'موقع الاستلام',
          snippet: widget.location?.address ?? 'موقع الاستلام المطلوب',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }

  Set<Polyline> get _polylines {
    if (_destinationLocation == null) return {};

    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [_effectiveCurrentLocation, _destinationLocation!],
        color: Colors.blue,
        width: 4,
        patterns: [PatternItem.dash(15), PatternItem.gap(10)],
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ),
    };
  }

  void _animateToShowBothLocations() {
    if (_mapController == null || _destinationLocation == null) return;

    double minLat = _effectiveCurrentLocation.latitude < _destinationLocation!.latitude
        ? _effectiveCurrentLocation.latitude
        : _destinationLocation!.latitude;
    double maxLat = _effectiveCurrentLocation.latitude > _destinationLocation!.latitude
        ? _effectiveCurrentLocation.latitude
        : _destinationLocation!.latitude;
    double minLng = _effectiveCurrentLocation.longitude < _destinationLocation!.longitude
        ? _effectiveCurrentLocation.longitude
        : _destinationLocation!.longitude;
    double maxLng = _effectiveCurrentLocation.longitude > _destinationLocation!.longitude
        ? _effectiveCurrentLocation.longitude
        : _destinationLocation!.longitude;

    double latPadding = (maxLat - minLat) * 0.3;
    double lngPadding = (maxLng - minLng) * 0.3;

    if (latPadding < 0.01) latPadding = 0.01;
    if (lngPadding < 0.01) lngPadding = 0.01;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat - latPadding, minLng - lngPadding),
      northeast: LatLng(maxLat + latPadding, maxLng + lngPadding),
    );

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_destinationLocation == null) {
      return Container(
        height: 300,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: const Center(
          child: Text(
            'لا يوجد موقع استلام متاح',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  (_effectiveCurrentLocation.latitude + _destinationLocation!.latitude) / 2,
                  (_effectiveCurrentLocation.longitude + _destinationLocation!.longitude) / 2,
                ),
                zoom: 12.0,
              ),
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (!_isLoadingLocation) {
                  Future.delayed(
                    const Duration(milliseconds: 800),
                    _animateToShowBothLocations,
                  );
                }
              },
              zoomControlsEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              mapToolbarEnabled: false,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),
          if (_isLoadingLocation)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'جاري تحديد الموقع...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _isUsingDefaultCurrent ? Colors.orange : Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'نقطة البداية',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'موقع الاستلام',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_locationError != null)
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _locationError!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_locationError != null && _locationError!.contains('إذن'))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FloatingActionButton.small(
                      onPressed: () async {
                        await _locationService.openAppSettings();
                      },
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.settings, color: Colors.white, size: 18),
                    ),
                  ),
                FloatingActionButton.small(
                  onPressed: _getCurrentLocation,
                  backgroundColor: Colors.white,
                  child: _isLoadingLocation
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
