import 'package:get_it/get_it.dart';
import 'package:x_go/core/app_cubit/app_cubit.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() {
  ///! FOR APP CUBIT ///

  getIt.registerFactory<AppCubit>(() => AppCubit());

  //!Api Services //

  ///! --DataSources-- ///

  /// !-- Repositories -- ///

  /// !-- UseCases -- ///

  // !Cubits //
}
