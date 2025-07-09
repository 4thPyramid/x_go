import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/services/service_locator.dart';
import 'package:x_go/features/language/presentation/logic/cubit/lang_cupit.dart';
import 'package:x_go/features/profile/presentation/components/account_details.dart';
import 'package:x_go/features/profile/presentation/components/profile_details.dart';
import 'package:x_go/features/profile/presentation/components/profile_hader_section.dart';
import 'package:x_go/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => getIt<ProfileEditCubit>()..getProfileData(),
                  child: ProfileHaderSection(),
                ),
                const ProfileDetails(),
                SizedBox(height: 16.h),
                const AccountDetails(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
