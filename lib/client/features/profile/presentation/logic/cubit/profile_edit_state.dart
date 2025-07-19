part of 'profile_edit_cubit.dart';

sealed class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object> get props => [];
}

final class ProfileEditInitial extends ProfileEditState {}
final class ProfileEditLoading extends ProfileEditState {}

final class ProfileEditLoaded extends ProfileEditState {
  final GetProfileResponse userProfile;
  const ProfileEditLoaded({required this.userProfile});
  @override
  List<Object> get props => [userProfile];
}

final class GetProfileDataLoaded extends ProfileEditState {
  final GetProfileResponse userProfile;
  const GetProfileDataLoaded({required this.userProfile});
  @override
  List<Object> get props => [userProfile];
}

final class ProfileEditError extends ProfileEditState {
  final String message;
  const ProfileEditError({required this.message});
  @override
  List<Object> get props => [message];
}
