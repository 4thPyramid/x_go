import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/client/features/profile/presentation/components/profile_form_fields.dart';
import 'package:x_go/client/features/profile/presentation/components/profile_header_section.dart';
import 'package:x_go/client/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  final String _image = '';
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    // Call Cubit to get profile data when screen opens
    context.read<ProfileEditCubit>().getProfileData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    context.read<ProfileEditCubit>().updateProfileData(
      name: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      image: _image,
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: BlocConsumer<ProfileEditCubit, ProfileEditState>(
          listener: (context, state) {
            if (state is GetProfileDataLoaded && !_hasLoaded) {
              _hasLoaded = true;
              _firstNameController.text = state.userProfile.data.name;
              _lastNameController.text = state.userProfile.data.lastName;
              _emailController.text = state.userProfile.data.email;
              _phoneController.text = state.userProfile.data.phone;
            }

            if (state is ProfileEditLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
            } else if (state is ProfileEditError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeaderSection(
                    icon: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45.w),
                    child: Column(
                      children: [
                        SizedBox(height: 25.h),

                        ProfileFormFields(
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          emailController: _emailController,
                          phoneController: _phoneController,
                        ),

                        SizedBox(height: 40.h),

                        state is ProfileEditLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                text: 'Save Change',
                                onPressed: _onSavePressed,
                              ),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
