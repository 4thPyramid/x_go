import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'client_tracking_state.dart';

class ClientTrackingCubit extends Cubit<ClientTrackingState> {
  ClientTrackingCubit() : super(InitialClientTrackingState());

  Set<Marker> markers = {};

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

          markers.add(
            Marker(markerId: MarkerId('1'), position: LatLng(lat, lng)),
          );
          emit(
            ClientTrackingSuccess(latLng: LatLng(lat, lng), markers: markers),
          );
        }
      });
      print(markers);
    } catch (e) {
      print(e.toString());
      emit(ClientTrackingError(errorMessage: e.toString()));
    }
  }
}
