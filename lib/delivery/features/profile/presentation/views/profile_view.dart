import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_empty_state_widget.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_error_state_widget.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_cubit.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_state.dart';
import 'package:x_go/delivery/features/profile/presentation/widgets/custom_Info_Profile_data.dart';
import 'package:x_go/delivery/features/profile/presentation/widgets/custom_all_title_profile.dart';
import 'package:x_go/delivery/features/profile/presentation/widgets/custom_curve_profile.dart';

class ProfileDeliveryView extends StatelessWidget {
  const ProfileDeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverProfileInfoCubit, DriverProfileInfoState>(
      builder: (context, state) {
        return SafeArea(
          child: state.when(
            initial: () => EmptyStateWidget(
              message: 'No Info yet',
              icon: Icons.local_taxi_outlined,
              onRefresh: () =>
                  context.read<DriverProfileInfoCubit>().fetchDriverProfile(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (deliveryInfo) => RefreshIndicator(
              onRefresh: () async {
                context.read<DriverProfileInfoCubit>().fetchDriverProfile();
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Fixed header section
                      CustomCurveProfile(),
                      SizedBox(height: 40.h), // Extra space for the card
                      // Scrollable content
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: CustomAllTitleProfile(),
                        ),
                      ),
                    ],
                  ),
                  // Fixed profile card
                  Positioned(
                    top: 70.h,
                    left: 10.w,
                    right: 10.w,
                    child: CustomInfoProfileData(
                      driverProfileEntity: deliveryInfo,
                    ),
                  ),
                ],
              ),
            ),
            error: (message) => ErrorStateWidget(
              message: message,
              onRetry: () =>
                  context.read<DriverProfileInfoCubit>().fetchDriverProfile(),
            ),
          ),
        );
      },
    );
  }
}
