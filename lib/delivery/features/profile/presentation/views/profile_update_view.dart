import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_update_request.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_cubit.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_state.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/update_profile/update_profile_cubit.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/update_profile/update_profile_state.dart';
import 'package:x_go/delivery/features/profile/presentation/widgets/form_update_profile.dart';

class DriverUpdateDetailsView extends StatefulWidget {
  const DriverUpdateDetailsView({super.key});

  @override
  State<DriverUpdateDetailsView> createState() =>
      _DriverUpdateDetailsViewState();
}

class _DriverUpdateDetailsViewState extends State<DriverUpdateDetailsView> {
  late UpdateProfileCubit _updateCubit;

  @override
  void initState() {
    super.initState();
    context.read<DriverProfileInfoCubit>().fetchDriverProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCubit = context.read<UpdateProfileCubit>();
  }

  @override
  void dispose() {
    _updateCubit.nameController.dispose();
    _updateCubit.emailController.dispose();
    _updateCubit.phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Driver Details',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              setState(() {
                context.read<UpdateProfileCubit>().isLoading = true;
              });
            },
            success: (message, _) {
              setState(() {
                context.read<UpdateProfileCubit>().isLoading = false;
              });

              Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );

              context.pop(true);
            },
            error: (message) {
              setState(() {
                context.read<UpdateProfileCubit>().isLoading = false;
              });

              Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            },
          );
        },
        child: BlocBuilder<DriverProfileInfoCubit, DriverProfileInfoState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('لا توجد بيانات')),
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
              success: (profile) {
                final cubit = context.read<UpdateProfileCubit>();

                // Populate once
                if (cubit.nameController.text.isEmpty) {
                  cubit.populateFields(profile);
                }

                return buildForm(context, cubit);
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'حدث خطأ: $message',
                      style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => context
                          .read<DriverProfileInfoCubit>()
                          .fetchDriverProfile(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 12.h,
                        ),
                      ),
                      child: Text(
                        'إعادة المحاولة',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void submitForm(BuildContext context, UpdateProfileCubit cubit) {
  if (cubit.formKey.currentState!.validate()) {
    final name = cubit.nameController.text;
    final email = cubit.emailController.text;
    final phone = cubit.phoneController.text;

    if (name == cubit.originalName &&
        email == cubit.originalEmail &&
        phone == cubit.originalPhone) {
      showToast(
        message: 'No Data Update Now ',
        state: ToastStates.WARNING,
        gravity: ToastGravity.CENTER_RIGHT,
      );
      return;
    }

    final request = DriverUpdateRequest(name: name, email: email, phone: phone);

    cubit.updateProfile(request);
  }
}
