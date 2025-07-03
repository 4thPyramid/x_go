import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/location/presentation/logic/cubit/location_cubit.dart';

class LocationActionsComponent extends StatelessWidget {
  const LocationActionsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Text(state.locationName ?? 'حدد عنوانك')),
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              BlocConsumer<LocationCubit, LocationState>(
                builder: (context, state) {
                  return state.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'تأكيد',
                          onPressed: () {
                            context.read<LocationCubit>().setLocation(
                              '30',
                              '30',
                              'Mansoura',
                            );
                          },
                        );
                },
                listener: (BuildContext context, LocationState state) {
                  if (state.isError) {
                    showToast(message: 'حدث خطأ', state: ToastStates.ERROR);
                  } else if (state.isSuccess) {
                    showToast(
                      message: 'تم تحديث الموقع بنجاح',
                      state: ToastStates.SUCCESS,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
