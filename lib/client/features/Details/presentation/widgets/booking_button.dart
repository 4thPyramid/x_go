import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/app_cubit/guest_mode/enums.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class BookingButton extends StatelessWidget {
  final CarEntity car;
  const BookingButton({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54.h,
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      child: ElevatedButton(
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
        style:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: AppColors.primaryColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ).copyWith(
              elevation: MaterialStateProperty.resolveWith<double>((
                Set<MaterialState> states,
              ) {
                if (states.contains(MaterialState.pressed)) return 8;
                if (states.contains(MaterialState.hovered)) return 4;
                return 2;
              }),
              backgroundColor: MaterialStateProperty.resolveWith<Color>((
                Set<MaterialState> states,
              ) {
                if (states.contains(MaterialState.pressed)) {
                  return AppColors.primaryColor.withOpacity(0.8);
                }
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.primaryColor.withOpacity(0.9);
                }
                return AppColors.primaryColor;
              }),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month_rounded, size: 20.r, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              'Book Now',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
