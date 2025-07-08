import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';
import 'package:x_go/features/profile/presentation/widgets/profile_header.dart';
import 'package:x_go/features/profile/presentation/widgets/user_card_info.dart';

class ProfileHaderSection extends StatelessWidget {
  const ProfileHaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProfileEditLoading:
            return const Center(child: CircularProgressIndicator());

          case ProfileEditError:
            final errorState = state as ProfileEditError;
            return Center(child: Text(errorState.message));

          case GetProfileDataLoaded:
            final loadedState = state as GetProfileDataLoaded;

            return Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                  child: Container(
                    height: 126.h,
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.primaryColor),
                    child: const ProfileHeader(),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: UserInfoCard(
                      name: loadedState.userProfile.data.name,
                      location:
                          loadedState.userProfile.data.location?.toString() ??
                          '',
                      imageUrl:
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?...', // الصورة ثابتة مؤقتًا
                    ),
                  ),
                ),
              ],
            );

          default:
            return const SizedBox(); // أو ممكن Placeholder()
        }
      },
    );
  }
}
