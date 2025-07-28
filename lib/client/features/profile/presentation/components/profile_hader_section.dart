import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';
import 'package:x_go/client/features/profile/presentation/widgets/profile_header.dart';
import 'package:x_go/client/features/profile/presentation/widgets/user_card_info.dart';

class ProfileHaderSection extends StatelessWidget {
  final VoidCallback? onSettingsPressed;

  const ProfileHaderSection({
    super.key,
    this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProfileEditLoading:
            return Container(
              height: 200.h,
              child: const Center(child: CircularProgressIndicator()),
            );

          case ProfileEditError:
            final errorState = state as ProfileEditError;
            return Container(
              height: 200.h,
              child: Center(child: Text(errorState.message)),
            );

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
                    child: CustomProfileHeader(
                      leadingIcon: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () async {
                          if (onSettingsPressed != null) {
                            onSettingsPressed!();
                          } else {
                            final result = await context.push(RouterNames.profileDetails);
                            if (context.mounted && result == true) {
                              context.read<ProfileEditCubit>().getProfileData();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: UserInfoCard(
                      onPressed:() async {
                          if (onSettingsPressed != null) {
                            onSettingsPressed!();
                          } else {
                            final result = await context.push(RouterNames.profileDetails);
                            if (context.mounted && result == true) {
                              context.read<ProfileEditCubit>().getProfileData();
                            }
                          }
                        },
                         

                      name: loadedState.userProfile.data.name,
                      lastName: loadedState.userProfile.data.lastName,
                      email: loadedState.userProfile.data.email,
                      imageUrl: loadedState.userProfile.data.image?.isNotEmpty == true
                          ? loadedState.userProfile.data.image!
                          : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                    ),
                  ),
                ),
              ],
            );

          default:
            return SizedBox(
              height: 200.h,
              child: const Center(child: Text('Loading profile...')),
            );
        }
      },
    );
  }
}