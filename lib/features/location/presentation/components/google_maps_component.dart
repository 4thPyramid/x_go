import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/features/location/presentation/logic/cubit/location_cubit.dart';
import 'package:x_go/features/location/presentation/widgets/google_map_widget.dart';

class GoogleMapsComponent extends StatefulWidget {
  const GoogleMapsComponent({super.key});

  @override
  State<GoogleMapsComponent> createState() => _GoogleMapsComponentState();
}

class _GoogleMapsComponentState extends State<GoogleMapsComponent> {
  GoogleMapController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return GoogleMapWidget(
          onMapCreated: (controller) {
            this.controller = controller;
          },
          initialLocation: state.currentPosition!,
          onTap: (position) {
            context.read<LocationCubit>().changeMarkerPosition(
              position,
              controller!,
            );
          },

          markers: {state.marker},
        );
      },
    );
  }
}
