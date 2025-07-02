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
import 'package:x_go/features/home/data/home_remote_d_S/home_remote_ds.dart';
import 'package:x_go/features/home/domain/repos/home_repository.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit.dart';

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
   getIt.registerLazySingleton<HomeRemoteDs>(
    () => HomeRemoteDsImpl( getIt<DioConsumer>()),
  );

  /// !-- Repositories -- ///
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );
   getIt.registerLazySingleton<HomeRepository>(
  () => HomeRepository(getIt<HomeRemoteDs>()), // ✅ صح، النوع اللي مسجله
);


  /// !-- UseCases -- ///
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
  // !Cubits //
  getIt.registerFactory<HomeCubit>(
    ()=>HomeCubit(getIt<HomeRepository>())
  );
}
