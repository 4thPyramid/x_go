import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/profile/domain/usecase/driver_profile_use_case.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/profile_info_cubit/driver_profile_info_state.dart';

class DriverProfileInfoCubit extends Cubit<DriverProfileInfoState> {
  DriverProfileInfoCubit(this.driverProfileUseCase)
    : super(DriverProfileInfoState.initial());
  final DriverProfileUseCase driverProfileUseCase;
  Future<void> fetchDriverProfile() async {
    emit(DriverProfileInfoState.loading());
    final result = await driverProfileUseCase(NoParams());
    emit(
      result.fold(
        (failure) => DriverProfileInfoState.error(failure.message),
        (driverProfile) => DriverProfileInfoState.success(driverProfile),
      ),
    );
  }
}
