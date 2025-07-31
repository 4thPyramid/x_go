import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/home_location_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/location_state.dart';

class AppBarDeliveryHome extends StatefulWidget {
  const AppBarDeliveryHome({super.key});

  @override
  State<AppBarDeliveryHome> createState() => _AppBarDeliveryHomeState();
}

class _AppBarDeliveryHomeState extends State<AppBarDeliveryHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeDeliveryLocationCubit>().fetchLocation();
  }

  void _showLocationDialog(String address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.location_on, size: 20.sp, color: Colors.black),
            SizedBox(width: 8.w),
            Text(
              'الموقع الكامل',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(
            address,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إغلاق', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  void _refreshLocation() {
    context.read<HomeDeliveryLocationCubit>().fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDeliveryLocationCubit, LocationState>(
      builder: (context, state) {
        String displayText = state.when(
          initial: () => 'جارٍ تحديد الموقع...',
          loading: () => 'جارٍ تحديد الموقع...',
          success: (address) => address,
          error: (message) => message,
        );

        return Row(
          children: [
            GestureDetector(
              onTap: () {
                state.maybeWhen(
                  success: (address) => _showLocationDialog(address),
                  error: (message) => _refreshLocation(),
                  orElse: () {},
                );
              },
              child: Row(
                children: [
                  Icon(
                    state.maybeWhen(
                      error: (message) => Icons.refresh,
                      orElse: () => Icons.location_on,
                    ),
                    color: state.maybeWhen(
                      error: (message) => Colors.red,
                      orElse: () => AppColors.primaryColor,
                    ),
                    size: 20.sp,
                  ),
                  SizedBox(width: 30.w),
                  SizedBox(
                    width: 200.w,
                    child: state.maybeWhen(
                      loading: () => Row(
                        children: [
                          SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              displayText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      orElse: () => Text(
                        displayText,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: state.maybeWhen(
                            error: (message) => Colors.red,
                            orElse: () => AppColors.black,
                          ),
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                Icons.search,
                color: AppColors.primaryColor,
                size: 28.w,
              ),
              onPressed: () {
                context.push(RouterNames.customSearchDeliveryApp);
              },
              tooltip: 'البحث',
            ),
          ],
        );
      },
    );
  }
}
