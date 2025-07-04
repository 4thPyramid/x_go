import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:x_go/core/app_cubit/app_cubit.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:x_go/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:x_go/features/auth/domain/repositories/auth_repository.dart';
import 'package:x_go/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:x_go/features/home/data/datasources/car_remote_datasource.dart';
import 'package:x_go/features/home/data/datasources/car_remote_datasource_impl.dart';
import 'package:x_go/features/home/data/repo/car_repo_impl.dart';
import 'package:x_go/features/home/domain/repo/car_repository.dart';
import 'package:x_go/features/home/domain/usecase/get_car_use_case.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';
import 'package:x_go/features/home/presentation/logic/home_cubit.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() {
  ///! FOR APP CUBIT ///
  getIt.registerFactory<AppCubit>(() => AppCubit());

  //!Api Services //
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: Dio()));

  ///! --DataSources-- ///
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiConsumer: getIt<DioConsumer>()),
  );
  getIt.registerLazySingleton<CarRemoteDatasource>(
    () => CarRemoteDatasourceImpl(apiConsumer: getIt<DioConsumer>()),
  );

   getIt.registerLazySingleton<HomeRemoteDs>(
    () => HomeRemoteDsImpl( getIt<DioConsumer>()),
  );

  /// !-- Repositories -- ///
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(remoteDatasource: getIt<CarRemoteDatasource>()),
  );

   getIt.registerLazySingleton<HomeRepository>(
  () => HomeRepository(getIt<HomeRemoteDs>()), // ✅ صح، النوع اللي مسجله
);


  /// !-- UseCases -- ///
  // Auth UseCases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<OtpUseCase>(
    () => OtpUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<AuthRepository>()),
  );

  // Car UseCases
  getIt.registerLazySingleton<GetCarsUseCase>(
    () => GetCarsUseCase(getIt<CarRepository>()),
  );
  getIt.registerLazySingleton<GetFilterInfoUseCase>(
    () => GetFilterInfoUseCase(getIt<CarRepository>()),
  );

  // !Cubits //

  getIt.registerFactory<CarCubit>(
        () => CarCubit(
      getCarsUseCase: getIt<GetCarsUseCase>(),
      getFilterInfoUseCase: getIt<GetFilterInfoUseCase>(),
    ),
  );
  getIt.registerFactory<HomeCubit>(
    ()=>HomeCubit(getIt<HomeRepository>())
  );
}
