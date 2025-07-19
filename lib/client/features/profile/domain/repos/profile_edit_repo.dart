import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/profile/data/dataSource/profile_remote_d_s.dart';
import 'package:x_go/client/features/profile/data/models/profile_edit_model.dart';

class ProfileEditRepo {
  final ProfileRemoteDs profileRemoteDs;

  ProfileEditRepo(this.profileRemoteDs);

  Future<Either<ErrorModel, GetProfileResponse>> updateProfileData(
    String name,
    String lastName,
    String image,
    String email,
    String phone,
  ) async {
    try {
      final response = await profileRemoteDs.updateProfileData(
        name,
        lastName,
        image,
        email,
        phone,
      );
      return Right(GetProfileResponse.fromJson(response));
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  Future<Either<ErrorModel, GetProfileResponse>> getProfileData() async {
    try {
      final response = await profileRemoteDs.getProfileData();
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
