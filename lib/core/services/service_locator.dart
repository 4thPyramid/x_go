import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/client/features/favorites/data/local_ds/favorites_local_ds.dart';

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
import 'package:x_go/client/features/home/data/datasources/car_local_datasource_impl.dart';
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
import 'package:x_go/core/services/google_map_service.dart';
import 'package:x_go/delivery/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:x_go/delivery/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:x_go/delivery/features/auth/domain/repositories/auth_repository.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/login_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/otp_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/register_usecase.dart';
import 'package:x_go/delivery/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:x_go/delivery/features/home/data/data_sources/local/orders_local_data_source.dart';
import 'package:x_go/delivery/features/home/data/data_sources/remote/oreders_status_ds.dart';
import 'package:x_go/delivery/features/home/data/repo/orders_repository_impl.dart';
import 'package:x_go/delivery/features/home/domain/repos/orders_repository.dart';
import 'package:x_go/delivery/features/home/domain/usecases/accepted_order_usecase.dart';
import 'package:x_go/delivery/features/home/domain/usecases/completed_order_usecase.dart';
import 'package:x_go/delivery/features/home/domain/usecases/new_order_usecase%20.dart';
import 'package:x_go/delivery/features/home/presentation/logic/accepted_status_cubit/oreder_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/completed_status_cubit/completed_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/home_location_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/home_location/locatin_services_home.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_status_cubit.dart';
import 'package:x_go/delivery/features/profile/data/data_source/local/driver_profile_local_data_source.dart';
import 'package:x_go/delivery/features/profile/data/data_source/remote/driver_profile_ds.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_profile_hive_model.dart';
import 'package:x_go/delivery/features/orderDetails/domain/useCases/change_stats_u_c.dart';
import 'package:x_go/delivery/features/profile/data/repo/driver_profile_repo_impl.dart';
import 'package:x_go/delivery/features/profile/domain/repos/driver_profile_repo.dart';
import 'package:x_go/delivery/features/profile/domain/usecase/driver_profile_use_case.dart';
import 'package:x_go/delivery/features/profile/domain/usecase/driver_update_use_case.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_cubit.dart';
import 'package:x_go/delivery/features/orderDetails/data/remoteeDS/order_details_remote_d_s.dart';
import 'package:x_go/delivery/features/orderDetails/data/repoImpl/order_details_repo_impl.dart';
import 'package:x_go/delivery/features/orderDetails/domain/repos/order_details_repo.dart';
import 'package:x_go/delivery/features/orderDetails/domain/useCases/order_details_u_c.dart';
import 'package:x_go/delivery/features/orderDetails/presentation/logic/booking_cubit.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/update_profile/update_profile_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  ///! FOR APP CUBIT ///
  getIt.registerFactory<AppCubit>(() => AppCubit());

  //!Api Services //
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: Dio()));
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));

  //! Hive Boxes //
  getIt.registerLazySingleton<Box>(() {
    try {
      return Hive.box('orders_box');
    } catch (e) {
      print('Error accessing Hive box: $e');
      // Return a mock box or handle the error gracefully
      throw Exception('Hive box not available');
    }
  });
  getIt.registerLazySingleton<Box<DriverProfileHiveModel>>(() {
    try {
      return Hive.box<DriverProfileHiveModel>('driverProfileBox');
    } catch (e) {
      print('Error accessing driverProfileBox: $e');
      throw Exception('driverProfileBox not available');
    }
  });

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

  getIt.registerLazySingleton<ProfileRemoteDs>(
    () => ProfileRemoteDsImpl(getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<BookingDetailsRemoteDataSource>(
    () => BookingDetailsRemoteDataSourceImpl(getIt<DioConsumer>()),
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
  // Home Data Sources
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );

  // Home Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: getIt<HomeRemoteDataSource>(),
      localDataSource: getIt<HomeLocalDataSource>(),
    ),
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
  getIt.registerLazySingleton(() => LocationService());
  getIt.registerLazySingleton<LocationHomeDeliveryService>(
    () => LocationHomeDeliveryServiceImpl(),
  );

  getIt.registerLazySingleton<ActiveLocationCubit>(
    () => ActiveLocationCubit(
      getActiveLocationUseCase: getIt<GetActiveLocationUseCase>(),
      locationService: getIt<LocationService>(),
    ),
  );

  getIt.registerFactory<HomeDeliveryLocationCubit>(
    () => HomeDeliveryLocationCubit(getIt<LocationHomeDeliveryService>()),
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
    () => FavoritesRepository(
      getIt<FavoritesLocalDataSource>(),
      apiConsumer: getIt<ApiConsumer>(),
    ),
  );
  getIt.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(),
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
  getIt.registerLazySingleton<OrdersLocalDataSource>(
    () => OrdersLocalDataSourceImpl(hiveBox: getIt<Box>()),
  );

  getIt.registerLazySingleton<OrdersStatusRepository>(
    () => OrdersStatusRepositoryImpl(
      localDataSource: getIt<OrdersLocalDataSource>(),
      dataSource: getIt<OrdersStatusDataSource>(),
    ),
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
  getIt.registerFactory<BookingDetailsCubit>(
    () => BookingDetailsCubit(
      getIt<GetBookingDetailsUseCase>(),
      getIt<ChangeBookingStatus>(),
    ),
  );
  getIt.registerLazySingleton<DriverProfileDataSource>(
    () => DriverProfileDataSourceImpl(getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<DriverProfileUseCase>(
    () => DriverProfileUseCase(getIt<DriverProfileRepository>()),
  );
  getIt.registerFactory<DriverProfileInfoCubit>(
    () => DriverProfileInfoCubit(getIt<DriverProfileUseCase>()),
  );
  // Driver Update Feature
  getIt.registerLazySingleton<DriverUpdateUseCase>(
    () => DriverUpdateUseCase(getIt<DriverProfileRepository>()),
  );
  getIt.registerFactory<UpdateProfileCubit>(
    () => UpdateProfileCubit(getIt<DriverUpdateUseCase>()),
  );
  getIt.registerLazySingleton<DriverProfileLocalDataSource>(
    () =>
        DriverProfileLocalDataSourceImpl(getIt<Box<DriverProfileHiveModel>>()),
  );
  getIt.registerLazySingleton<DriverProfileRepository>(
    () => DriverProfileRepositoryImpl(
      getIt<DriverProfileDataSource>(),
      getIt<DriverProfileLocalDataSource>(),
    ),
  );
}
