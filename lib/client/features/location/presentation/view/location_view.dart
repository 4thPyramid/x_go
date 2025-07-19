import 'package:flutter/material.dart';
import 'package:x_go/client/features/location/presentation/components/google_maps_component.dart';
import 'package:x_go/client/features/location/presentation/components/location_actions.dart';
import 'package:x_go/client/features/location/presentation/widgets/floating_action_button.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMapsComponent(),
          FloatingActionButtonWidget(),
          LocationActionsComponent(),
        ],
      ),
    );
  }
}
