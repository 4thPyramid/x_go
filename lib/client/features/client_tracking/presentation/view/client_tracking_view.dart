import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/client/features/client_tracking/presentation/logic/cubit/client_tracking_cubit.dart';
import 'package:x_go/client/features/location/presentation/widgets/google_map_widget.dart';

class ClientTrackingView extends StatelessWidget {
  const ClientTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ClientTrackingCubit, ClientTrackingState>(
          builder: (context, state) {
            if (state is ClientTrackingSuccess) {
              return GoogleMapWidget(
                initialLocation: state.latLng,
                onTap: (value) {},
                markers: state.markers,
                onMapCreated: (value) {},
              );
            } else if (state is ClientTrackingError) {
              return Center(child: Text(state.errorMessage));
            } else if (state is ClientTrackingLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
