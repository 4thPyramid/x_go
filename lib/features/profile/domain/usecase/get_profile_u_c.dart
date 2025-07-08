import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/profile/data/models/profile_edit_model.dart';
import '../repos/profile_edit_repo.dart';

class GetProfileUC {
  final ProfileEditRepo repo;

  GetProfileUC(this.repo);

  Future<Either<ErrorModel, GetProfileResponse>> call() {
    return repo.getProfileData();
  }
}
