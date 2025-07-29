import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/app_cubit/guest_mode/enums.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class BookingButton extends StatelessWidget {
  final CarEntity car;
  const BookingButton({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        text: 'Book Now',
        onPressed: () {
          final isGuest =
              context.read<SessionCubit>().state.status == AuthStatus.guest;

          if (isGuest) {
            showToast(
              message: 'Please log in to book a car',
              state: ToastStates.ERROR,
            );
            return;
          }
          context.push(RouterNames.carBooking, extra: car);
        },
      ),
    );
  }
}
