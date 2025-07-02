import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit() : super(ProfileEditInitial());
}
