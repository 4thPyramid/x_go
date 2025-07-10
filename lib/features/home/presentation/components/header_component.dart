// features/home/presentation/components/header_component.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/utils/app_assets.dart';
import 'package:x_go/core/utils/app_image_view.dart';
import 'package:x_go/features/home/presentation/logic/cubit/active_location/active_location_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/active_location/active_location_state.dart';

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key});

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  void initState() {
    super.initState();
    context.read<ActiveLocationCubit>().getActiveLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        BlocBuilder<ActiveLocationCubit, ActiveLocationState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.read<ActiveLocationCubit>().getActiveLocation();
              },
              child: Row(
                children: [
                  _buildLocationText(state),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey[600],
                    size: 20.sp,
                  ),
                ],
              ),
            );
          },
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildLocationText(ActiveLocationState state) {
    switch (state.runtimeType) {
      case const (ActiveLocationLoading):
        return Row(
          children: [
            SizedBox(
              width: 12.w,
              height: 12.h,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8.w),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
            ),
          ],
        );

      case const (ActiveLocationLoaded):
        final locationState = state as ActiveLocationLoaded;
        return Row(
          children: [
            Icon(Icons.location_on, size: 16.sp, color: Colors.black),
            SizedBox(width: 4.w),
            Text(
              _formatLocationName(
                locationState.activeLocation.location.toString(),
              ),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        );

      case const (ActiveLocationError):
        final errorState = state as ActiveLocationError;
        return Row(
          children: [
            Icon(Icons.location_off, size: 16.sp, color: Colors.red),
            SizedBox(width: 4.w),
            Text(
              errorState.message.tr(),
              style: TextStyle(fontSize: 13.sp, color: Colors.red),
            ),
          ],
        );
      default:
        return Text('No Location Selected', style: TextStyle(fontSize: 13.sp));
    }
  }

  String _formatLocationName(String location) {
    if (location.isEmpty) return 'Unknown Location';
    return '${location[0].toUpperCase()}${location.substring(65)}, Egypt';
  }
}
