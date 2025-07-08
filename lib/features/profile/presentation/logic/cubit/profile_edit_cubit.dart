import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:x_go/features/profile/data/models/profile_edit_model.dart';
import 'package:x_go/features/profile/domain/usecase/get_profile_u_c.dart';
import 'package:x_go/features/profile/domain/usecase/update_profile_u_c.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final UpdateProfileUC updateProfileUC;
  final GetProfileUC getProfileUC;

  ProfileEditCubit(this.updateProfileUC, this.getProfileUC) : super(ProfileEditInitial());

  Future<void> updateProfileData({
    required String name,
    required String lastName,
    required String image,
    required String email,
    required String phone,
  }) async {
    emit(ProfileEditLoading());
    final response = await updateProfileUC.call(name, lastName, image, email, phone);
    response.fold(
      (error) => emit(ProfileEditError(message: error.message)),
      (userProfile) => emit(ProfileEditLoaded(userProfile: userProfile)),
    );
  }

  Future<void> getProfileData() async {
    emit(ProfileEditLoading());
    final response = await getProfileUC.call();
    response.fold(
      (error) => emit(ProfileEditError(message: error.message)),
      (profileData) => emit(GetProfileDataLoaded(userProfile: profileData )),
    );
  }
}
