import 'package:flutter/material.dart';
import 'package:x_go/delivery/features/profile/presentation/widgets/custom_Info_Profile_data.dart';
import 'package:x_go/delivery/features/profile/presentation/widgets/custom_curve_profile.dart';

class ProfileDeliveryView extends StatelessWidget {
  const ProfileDeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Column(children: [CustomCurveProfile()]),
            CustomInfoProfileData(),
          ],
        ),
      ),
    );
  }
}
