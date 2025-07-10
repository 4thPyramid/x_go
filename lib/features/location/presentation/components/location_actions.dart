import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/location/presentation/logic/cubit/location_cubit.dart';

class LocationActionsComponent extends StatefulWidget {
  const LocationActionsComponent({super.key});

  @override
  State<LocationActionsComponent> createState() =>
      _LocationActionsComponentState();
}

class _LocationActionsComponentState extends State<LocationActionsComponent> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Container(
          height: 200.h,
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
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryColor,
                  ),

                  Expanded(child: Text(state.locationName ?? 'حدد عنوانك',textAlign: TextAlign.right,maxLines: 2,overflow:  TextOverflow.ellipsis,style: TextStyle( ),)),
                ],
              ),
              SizedBox(height: 16.h),
              ActiveCheckBoxComponent(
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
              ),
              BlocConsumer<LocationCubit, LocationState>(
                builder: (context, state) {
                  return state.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'تأكيد',

                          onPressed: () {
                            context.read<LocationCubit>().setLocation(
                              state.currentPosition!.latitude.toString(),
                              state.currentPosition!.longitude.toString(),
                              state.locationName!,
                              isActive,
                            );
                          },
                        );
                },
                listener: (BuildContext context, LocationState state) {
                  if (state.isError) {
                    showToast(
                      message: state.errorMessage,
                      state: ToastStates.ERROR,
                    );
                  } else if (state.isSuccess) {
                    showToast(
                      message: 'تم تحديث الموقع بنجاح',
                      state: ToastStates.SUCCESS,
                    );
                    context.pop();

                    context.pop();
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

class ActiveCheckBoxComponent extends StatefulWidget {
  const ActiveCheckBoxComponent({super.key, required this.onChanged});

  final Function(bool) onChanged;

  @override
  State<ActiveCheckBoxComponent> createState() =>
      _ActiveCheckBoxComponentState();
}

class _ActiveCheckBoxComponentState extends State<ActiveCheckBoxComponent> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isActive,
          onChanged: (value) {
            setState(() {
              isActive = value!;
            });
            widget.onChanged(value!);
          },
        ),
        Text('is Active'),
      ],
    );
  }
}
