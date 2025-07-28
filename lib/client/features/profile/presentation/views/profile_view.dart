import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/client/features/language/presentation/logic/cubit/lang_cupit.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/client/features/profile/presentation/components/account_details.dart';
import 'package:x_go/client/features/profile/presentation/components/profile_details.dart';
import 'package:x_go/client/features/profile/presentation/components/profile_hader_section.dart';
import 'package:x_go/client/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        final cubit = getIt<ProfileEditCubit>()..getProfileData();

        return BlocProvider.value(
          value: cubit,
          child: Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            body: BlocListener<ProfileEditCubit, ProfileEditState>(
              listener: (context, state) {
                if (state is ProfileEditInitial) {
                  cubit;
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileHaderSection(),
                    const ProfileDetails(),
                    SizedBox(height: 16.h),
                    const AccountDetails(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}