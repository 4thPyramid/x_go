import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/profile/data/models/profile_edit_model.dart';
import '../repos/profile_edit_repo.dart';

class UpdateProfileUC {
  final ProfileEditRepo profileEditRepo;

  UpdateProfileUC(this.profileEditRepo);

  Future<Either<ErrorModel, GetProfileResponse>> call(
    String name,
    String lastName,
    String image,
    String email,
    String phone,
  ) {
    return profileEditRepo.updateProfileData(
      name,
      lastName,
      image,
      email,
      phone,
    );
  }
}
