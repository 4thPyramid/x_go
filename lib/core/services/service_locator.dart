// core/di/dependency_injection.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:x_go/core/app_cubit/app_cubit.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/client/features/Details/data/datasources/car_detail_remote_data_source.dart';
import 'package:x_go/client/features/Details/data/repo/car_detail_repository_impl.dart';
import 'package:x_go/client/features/Details/domain/repo/car_detail_repository.dart';
import 'package:x_go/client/features/Details/domain/usecase/get_car_detail_usecase.dart';
import 'package:x_go/client/features/Details/presentation/logic/cubit/car_detail_cubit.dart';
import 'package:x_go/client/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:x_go/client/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:x_go/client/features/auth/domain/repositories/auth_repository.dart';
import 'package:x_go/client/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/client/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/client/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:x_go/client/features/home/data/datasources/active_location_remote_data_source.dart';
import 'package:x_go/client/features/home/data/datasources/car_remote_datasource_impl.dart';
import 'package:x_go/client/features/home/data/repo/active_location_repository_impl.dart';
import 'package:x_go/client/features/home/data/repo/car_repo_impl.dart';
import 'package:x_go/client/features/home/domain/repo/active_location_repository.dart';
import 'package:x_go/client/features/home/domain/repo/car_repository.dart';
import 'package:x_go/client/features/home/domain/usecase/get_active_location_usecase.dart';
import 'package:x_go/client/features/home/domain/usecase/get_car_use_case.dart';
import 'package:x_go/client/features/home/domain/usecase/get_filter_info_usecase.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/active_location/active_location_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/my_bookings/data/remote_d_s/booking_remote_d_s.dart';
import 'package:x_go/client/features/my_bookings/data/repos/booking_repo_impl.dart';
import 'package:x_go/client/features/my_bookings/domain/repos/booking_repo.dart';
import 'package:x_go/client/features/my_bookings/domain/usecases/get_booking_use_case.dart';
import 'package:x_go/client/features/my_bookings/presentation/logic/cubit/my_booking_cubit.dart';

import 'package:x_go/client/features/profile/data/dataSource/profile_remote_d_s.dart';
import 'package:x_go/client/features/profile/domain/repos/profile_edit_repo.dart';
import 'package:x_go/client/features/profile/domain/usecase/get_profile_u_c.dart';
import 'package:x_go/client/features/profile/domain/usecase/update_profile_u_c.dart';
import 'package:x_go/client/features/profile/presentation/logic/cubit/profile_edit_cubit.dart';
import 'package:x_go/client/features/language/presentation/logic/cubit/lang_cupit.dart';
import 'package:x_go/client/features/favorites/data/repositories/favorites_repository.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_cubit.dart';
import 'package:x_go/delivery/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:x_go/delivery/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:x_go/delivery/features/auth/domain/repositories/auth_repository.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:x_go/delivery/features/home/data/data_sources/oreders_status_ds.dart';
import 'package:x_go/delivery/features/home/data/repo/accepted_orders_repository_impl.dart';
import 'package:x_go/delivery/features/home/domain/repos/accepted_orders_repository.dart';
import 'package:x_go/delivery/features/home/domain/usecases/accepted_order_usecase.dart';
import 'package:x_go/delivery/features/home/domain/usecases/completed_order_usecase.dart';
import 'package:x_go/delivery/features/home/domain/usecases/new_order_usecase%20.dart';
import 'package:x_go/delivery/features/home/presentation/logic/accepted_status_cubit/oreder_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/completed_status_cubit/new_order_cubit/completed_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_status_cubit.dart';
import 'package:x_go/delivery/features/profile/data/data_source/driver_profile_ds.dart';
import 'package:x_go/delivery/features/profile/data/repo/driver_profile_repo_impl.dart';
import 'package:x_go/delivery/features/profile/domain/repos/driver_profile_repo.dart';
import 'package:x_go/delivery/features/profile/domain/usecase/driver_profile_use_case.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_cubit.dart';
import 'package:x_go/delivery/features/orderDetails/data/remoteeDS/order_details_remote_d_s.dart';
import 'package:x_go/delivery/features/orderDetails/data/repoImpl/order_details_repo_impl.dart';
import 'package:x_go/delivery/features/orderDetails/domain/repos/order_details_repo.dart';
import 'package:x_go/delivery/features/orderDetails/domain/useCases/order_details_u_c.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  ///! FOR APP CUBIT ///
  getIt.registerFactory<AppCubit>(() => AppCubit());

  //!Api Services //
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: Dio()));
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));

  ///! --DataSources-- ///
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiConsumer: getIt<DioConsumer>()),
  );

  getIt.registerLazySingleton<DeliveryAuthRemoteDataSource>(
    () => DeliveryAuthRemoteDataSourceImpl(apiConsumer: getIt<DioConsumer>()),
  );

  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSource(getIt<DioConsumer>()),
  );

  // Home Remote Data Source
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiConsumer: getIt<DioConsumer>()),
  );
  getIt.registerLazySingleton<ProfileRemoteDs>(
    () => ProfileRemoteDsImpl(getIt<ApiConsumer>()),
  );

  /// !-- Repositories -- ///
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<DeliveryAuthRepository>(
    () => DeliveryAuthRepositoryImpl(
      remoteDataSource: getIt<DeliveryAuthRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepoImpl(remoteDataSource: getIt<BookingRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ProfileEditRepo>(
    () => ProfileEditRepo(getIt<ProfileRemoteDs>()),
  );
  getIt.registerLazySingleton<BookingDetailsRepository>(
    () => BookingDetailsRepositoryImpl(getIt<BookingDetailsRemoteDataSource>()),
  );
  // Home Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: getIt<HomeRemoteDataSource>()),
  );
  getIt.registerLazySingleton<ActiveLocationRemoteDataSource>(
    () => ActiveLocationRemoteDataSourceImpl(apiConsumer: getIt<DioConsumer>()),
  );

  /// !-- UseCases -- ///
  /// Booking Details UseCases
  getIt.registerLazySingleton<GetBookingDetailsUseCase>(
    () => GetBookingDetailsUseCase(getIt<BookingDetailsRepository>()),
  );

  // Auth UseCases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<DeliveryLoginUseCase>(
    () => DeliveryLoginUseCase(getIt<DeliveryAuthRepository>()),
  );
  getIt.registerLazySingleton<GetBookingList>(
    () => GetBookingList(getIt<BookingRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<DeliveryRegisterUseCase>(
    () => DeliveryRegisterUseCase(getIt<DeliveryAuthRepository>()),
  );
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
    () => ForgetPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<DeliveryForgetPasswordUseCase>(
    () => DeliveryForgetPasswordUseCase(getIt<DeliveryAuthRepository>()),
  );
  getIt.registerLazySingleton<OtpUseCase>(
    () => OtpUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<DeliveryOtpUseCase>(
    () => DeliveryOtpUseCase(getIt<DeliveryAuthRepository>()),
  );
  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<DeliveryResetPasswordUseCase>(
    () => DeliveryResetPasswordUseCase(getIt<DeliveryAuthRepository>()),
  );
  getIt.registerLazySingleton<ActiveLocationRepository>(
    () => ActiveLocationRepositoryImpl(
      remoteDataSource: getIt<ActiveLocationRemoteDataSource>(),
    ),
  );

  // Home UseCases
  getIt.registerLazySingleton<GetCarsUseCase>(
    () => GetCarsUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetFilterInfoUseCase>(
    () => GetFilterInfoUseCase(getIt<HomeRepository>()),
  );
  getIt.registerLazySingleton<GetProfileUC>(
    () => GetProfileUC(getIt<ProfileEditRepo>()),
  );
  getIt.registerLazySingleton<UpdateProfileUC>(
    () => UpdateProfileUC(getIt<ProfileEditRepo>()),
  );
  getIt.registerLazySingleton<GetActiveLocationUseCase>(
    () => GetActiveLocationUseCase(getIt<ActiveLocationRepository>()),
  );

  // !Cubits //
  getIt.registerFactory<ActiveLocationCubit>(
    () => ActiveLocationCubit(
      getActiveLocationUseCase: getIt<GetActiveLocationUseCase>(),
    ),
  );
  getIt.registerFactory<MyBookingCubit>(
    () => MyBookingCubit(getIt<GetBookingList>()),
  );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getCarsUseCase: getIt<GetCarsUseCase>(),
      getFilterInfoUseCase: getIt<GetFilterInfoUseCase>(),
    ),
  );
  getIt.registerFactory<ProfileEditCubit>(
    () => ProfileEditCubit(getIt<UpdateProfileUC>(), getIt<GetProfileUC>()),
  );
  getIt.registerFactory<LocalizationCubit>(() => LocalizationCubit());

  // Favorites Feature
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepository(apiConsumer: getIt<ApiConsumer>()),
  );

  // Car Detail Feature
  getIt.registerLazySingleton<CarDetailRemoteDataSource>(
    () => CarDetailRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<CarDetailRepository>(
    () => CarDetailRepositoryImpl(
      remoteDataSource: getIt<CarDetailRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetCarDetailUseCase>(
    () => GetCarDetailUseCase(repository: getIt<CarDetailRepository>()),
  );

  getIt.registerFactory<CarDetailCubit>(
    () => CarDetailCubit(getCarDetailUseCase: getIt<GetCarDetailUseCase>()),
  );

  getIt.registerLazySingleton<FavoritesCubit>(
    () => FavoritesCubit(favoritesRepository: getIt<FavoritesRepository>()),
  );
  getIt.registerLazySingleton<OrdersStatusDataSource>(
    () => OrdersStatusDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<OrdersStatusRepository>(
    () =>
        OrdersStatusRepositoryImpl(dataSource: getIt<OrdersStatusDataSource>()),
  );
  getIt.registerLazySingleton<GetAcceptedOrdersUseCase>(
    () => GetAcceptedOrdersUseCase(getIt<OrdersStatusRepository>()),
  );
  getIt.registerLazySingleton<GetNewOrdersUseCase>(
    () => GetNewOrdersUseCase(getIt<OrdersStatusRepository>()),
  );
  getIt.registerFactory<AcceptedOrdersCubit>(
    () => AcceptedOrdersCubit(getIt<GetAcceptedOrdersUseCase>()),
  );
  getIt.registerFactory<NewOrdersCubit>(
    () => NewOrdersCubit(getIt<GetNewOrdersUseCase>()),
  );
  getIt.registerLazySingleton<GetCompletedOrdersUseCase>(
    () => GetCompletedOrdersUseCase(getIt<OrdersStatusRepository>()),
  );
  getIt.registerFactory<CompletedOrdersCubit>(
    () => CompletedOrdersCubit(getIt<GetCompletedOrdersUseCase>()),
  );

  ///delivery profile
  getIt.registerLazySingleton<DriverProfileDataSource>(
    () => DriverProfileDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<DriverProfileRepository>(
    () => DriverProfileRepositoryImpl(
      dataSource: getIt<DriverProfileDataSource>(),
    ),
  );
  getIt.registerLazySingleton<DriverProfileUseCase>(
    () => DriverProfileUseCase(getIt<DriverProfileRepository>()),
  );
  getIt.registerFactory<DriverProfileInfoCubit>(
    () => DriverProfileInfoCubit(getIt<DriverProfileUseCase>()),
  );
}
