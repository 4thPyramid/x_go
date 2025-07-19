import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/client/features/location/presentation/widgets/google_map_widget.dart';

class DeliveryLocationView extends StatelessWidget {
  const DeliveryLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMapWidget(
            initialLocation: LatLng(31.286417, 29.990606),
            onTap: (value) {},
            markers: {},
            onMapCreated: (controller) {},
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text('waleed seafan'), Text('مندوب التوصيل')],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
