import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'client_tracking_state.dart';

class ClientTrackingCubit extends Cubit<ClientTrackingState> {
  ClientTrackingCubit() : super(InitialClientTrackingState());

  Set<Marker> markers = {};
  String hash = '';
  Set<Polyline> polylines = {};

  getLiveTrackingFromFirebase() {
    emit(ClientTrackingLoading());
    try {
      DatabaseReference orderLocationRef = FirebaseDatabase.instance
          .ref()
          .child('orders/order_abc123/location');

      orderLocationRef.onValue.listen((event) {
        final data = event.snapshot.value as Map?;
        print(data.toString());
        if (data != null) {
          double lat = data['latitude'];
          double lng = data['longitude'];
          hash = data['polyline'];

          decodePolyline(hash);
          markers.add(
            Marker(markerId: MarkerId('1'), position: LatLng(lat, lng)),
          );
          emit(
            ClientTrackingSuccess(
              hash: hash,
              latLng: LatLng(lat, lng),
              markers: markers,
              polylines: polylines,
            ),
          );
        }
      });
      print(markers);
    } catch (e) {
      print(e.toString());
      emit(ClientTrackingError(errorMessage: e.toString()));
    }
  }

  Set<Polyline> decodePolyline(String encodedPolyline) {
    List<PointLatLng> result = PolylinePoints.decodePolyline(encodedPolyline);
    List<LatLng> polylineCoordinates = result
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();

    polylines.add(
      Polyline(
        polylineId: const PolylineId("route"),
        color: const Color(0xFF4285F4),
        width: 5,
        points: polylineCoordinates,
      ),
    );

    if (polylineCoordinates.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: polylineCoordinates.last,

          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    return polylines;
  }
}
