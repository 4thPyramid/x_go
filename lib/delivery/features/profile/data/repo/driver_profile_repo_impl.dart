import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/delivery/features/profile/data/data_source/local/driver_profile_local_data_source.dart';
import 'package:x_go/delivery/features/profile/data/data_source/remote/driver_profile_ds.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_profile_hive_model.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_update_request.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_update_entity.dart';
import 'package:x_go/delivery/features/profile/domain/repos/driver_profile_repo.dart';

class DriverProfileRepositoryImpl implements DriverProfileRepository {
  final DriverProfileDataSource dataSource;
  final DriverProfileLocalDataSource localDataSource;

  DriverProfileRepositoryImpl(this.dataSource, this.localDataSource);

  @override
  Future<Either<ErrorModel, DriverProfileEntity>> getDriverProfile() async {
    // 1. Load from cache first (إذا وجد)
    final cached = await localDataSource.getCachedDriverProfile();
    // 2. If cache exists, return it immediately
    if (cached != null) {
      final cachedEntity = cached.toEntity();
      // 3. Silently update from API in background (بدون انتظار)
      _silentlyUpdateFromAPI();

      // 4. Return cached data immediately
      return Right(cachedEntity);
    }

    // 5. If no cache, fetch from API (first time or no cached data)
    return await _fetchFromAPI();
  }

  /// تحديث البيانات من الـ API في الخلفية
  void _silentlyUpdateFromAPI() async {
    try {
      final response = await dataSource.getDriverProfile();
      final profileData = response.data!.toEntity();

      // حفظ البيانات الجديدة في الكاش للمرة القادمة
      await localDataSource.cacheDriverProfile(
        DriverProfileHiveModel.fromEntity(profileData),
      );
    } catch (e) {
      // البيانات المحفوظة مسبقًا ما زالت صالحة
      print('Silent update failed: $e');
    }
  }

  /// جلب البيانات من الـ API مع معالجة الأخطاء
  Future<Either<ErrorModel, DriverProfileEntity>> _fetchFromAPI() async {
    try {
      final response = await dataSource.getDriverProfile();
      final profileData = response.data!.toEntity();

      // حفظ البيانات محليًا
      await localDataSource.cacheDriverProfile(
        DriverProfileHiveModel.fromEntity(profileData),
      );

      return Right(profileData);
    } on DioException catch (_) {
      return Left(ErrorModel(message: "No Internet connection"));
    } on ServerException catch (_) {
      return Left(ErrorModel(message: "Server error occurred"));
    } catch (e) {
      return Left(ErrorModel(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<ErrorModel, DriverUpdateEntity>> updateDriverProfile({
    required DriverUpdateRequest driverUpdateRequest,
  }) {
    return _updateDriverProfile(driverUpdateRequest);
  }

  Future<Either<ErrorModel, DriverUpdateEntity>> _updateDriverProfile(
    DriverUpdateRequest driverUpdateRequest,
  ) async {
    try {
      final response = await dataSource.updateDriverProfile(
        driverUpdateRequest,
      );

      // Make sure the data field is not null
      if (response.data == null) {
        return Left(
          ErrorModel(message: "Profile update response data is null"),
        );
      }

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
