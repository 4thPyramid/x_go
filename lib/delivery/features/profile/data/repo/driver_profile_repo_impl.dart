import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/delivery/features/profile/data/data_source/driver_profile_ds.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';
import 'package:x_go/delivery/features/profile/domain/repos/driver_profile_repo.dart';

class DriverProfileRepositoryImpl implements DriverProfileRepository {
  final DriverProfileDataSource dataSource;

  DriverProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ErrorModel, DriverProfileEntity>> getDriverProfile() async {
    try {
      final response = await dataSource.getDriverProfile();
      final profileData = response.data!.toEntity();

      return Right(profileData);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message ?? "Unknown Dio error"));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: "Unexpected error: ${e.toString()}"));
    }
  }
}
